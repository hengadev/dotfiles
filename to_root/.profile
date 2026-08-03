# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
. "$HOME/.cargo/env"

# export cargo bin and go bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:/usr/local/go/bin
# for the go binaries that I get with "go install"
export PATH=$PATH:$HOME/go/bin
# wezterm path
export PATH=$PATH:/usr/bin/wezterm
export PATH=$PATH:/bin/wezterm

export MISTRAL_API_KEY=REPLACE_WITH_MISTRAL_API_KEY

# Z.ai related
export ZAI_API_KEY=REPLACE_WITH_ZAI_API_KEY
export ZAI_BASE_URL=https://api.z.ai/api/anthropic
export GLM_OPUS_MODEL="GLM-4.6"
export GLM_SONNET_MODEL="GLM-4.6"
export GLM_HAIKU_MODEL="GLM-4.5-Air"
