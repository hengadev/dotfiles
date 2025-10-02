#!/usr/bin/env python3
import gi # type: ignore
gi.require_version("Playerctl", "2.0")
from gi.repository import Playerctl, GLib
import sys
import signal
import json
import logging
import os

# Optional logging to a file
LOG_FILE = os.path.expanduser("~/.config/waybar/media-player.log")
logging.basicConfig(filename=LOG_FILE, level=logging.WARNING,
                    format="%(asctime)s %(levelname)s: %(message)s")
logger = logging.getLogger(__name__)

# Icons
ICON_PLAYING = " "   # FontAwesome / Nerd Font required
ICON_PAUSED  = " "

class MediaManager:
    def __init__(self):
        self.manager = Playerctl.PlayerManager()
        self.loop = GLib.MainLoop()
        self.manager.connect("name-appeared", self.on_player_appeared)
        self.manager.connect("player-vanished", self.on_player_vanished)

        # Signal handling
        signal.signal(signal.SIGINT, self.stop_loop)
        signal.signal(signal.SIGTERM, self.stop_loop)

        self.players = {}

    def stop_loop(self, sig, frame):
        logger.info("Exiting MediaManager")
        self.loop.quit()

    def on_player_appeared(self, manager, player_name):
        try:
            player = Playerctl.Player.new_from_name(player_name)
            player.connect("metadata", self.on_metadata_changed)
            player.connect("playback-status", self.on_playback_status_changed)
            manager.manage_player(player)
            self.players[player_name] = player
            self.update_display()
        except Exception as e:
            self.write_error(f"Error initializing {player_name}: {e}")

    def on_player_vanished(self, manager, player_name):
        if player_name in self.players:
            del self.players[player_name]
        self.update_display()

    def on_metadata_changed(self, player, metadata):
        self.update_display()

    def on_playback_status_changed(self, player, status):
        self.update_display()

    def get_current_player(self):
        # Prefer a playing player
        for player in reversed(list(self.players.values())):
            if player.props.status == "Playing":
                return player
        # Otherwise return any player
        return next(iter(self.players.values()), None)

    def update_display(self):
        player = self.get_current_player()
        if not player:
            self.write_output("")
            return

        artist = player.get_artist() or ""
        title = player.get_title() or ""
        status = player.props.status

        text = f"{artist} - {title}" if artist else title
        if not text:
            text = "Unknown track"

        if status == "Playing":
            text = ICON_PLAYING + text
        else:
            text = ICON_PAUSED + text

        output = {
            "text": text,
            "class": "custom-" + player.props.identity.lower().replace(" ", "-"),
            "alt": player.props.identity
        }
        self.write_json(output)

    def write_json(self, output):
        try:
            sys.stdout.write(json.dumps(output) + "\n")
            sys.stdout.flush()
        except Exception as e:
            self.write_error(f"JSON write error: {e}")

    def write_output(self, text):
        self.write_json({"text": text})

    def write_error(self, msg):
        logger.error(msg)
        self.write_json({"text": "Error: " + msg})

    def run(self):
        try:
            self.loop.run()
        except Exception as e:
            self.write_error(f"Main loop crashed: {e}")


if __name__ == "__main__":
    manager = MediaManager()
    manager.run()

