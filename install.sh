#!/bin/sh

mkdir -pv /usr/share/jarvis/.cache
touch /usr/share/jarvis/.cache/dummy_to_silence_zsh_leave_777
chmod 777 /usr/share/jarvis/.cache
install -v -m 444 zshrc /usr/share/jarvis/.zshrc
install -v -m 444 funcs.d/* /usr/share/jarvis/funcs.d
install -v -m 444 README.md img/* /usr/share/jarvis/
install -v jarvis /usr/bin/jarvis