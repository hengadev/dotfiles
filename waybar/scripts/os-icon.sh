#!/usr/bin/env bash
# Prints {"text": <glyph>, "class": <distro>} matching the running distro
# (from /etc/os-release ID / ID_LIKE), so waybar can both show the right
# logo and apply a per-distro accent color via CSS class.
# Codepoints are from the Nerd Fonts "Linux" (font-logos) glyph set.

. /etc/os-release

case "${ID:-}${ID_LIKE:+ $ID_LIKE}" in
    *arch*)                      glyph=$''; class=arch ;;
    *ubuntu*)                    glyph=$''; class=ubuntu ;;
    *debian*)                    glyph=$''; class=debian ;;
    *fedora*)                    glyph=$''; class=fedora ;;
    *nixos*)                     glyph=$''; class=nixos ;;
    *manjaro*)                   glyph=$''; class=manjaro ;;
    *opensuse*)                  glyph=$''; class=opensuse ;;
    *"linux mint"*|*linuxmint*)  glyph=$''; class=mint ;;
    *raspbian*)                  glyph=$''; class=raspberrypi ;;
    *)                           glyph=$''; class=tux ;;
esac

printf '{"text":"%s","class":"%s"}\n' "$glyph" "$class"
