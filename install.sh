#!/bin/sh

mkdir -pv ${DESTDIR}/usr/share/jarvis/.cache
touch ${DESTDIR}/usr/share/jarvis/.cache/dummy_to_silence_zsh_leave_777
chmod 777 ${DESTDIR}/usr/share/jarvis/.cache
touch ${DESTDIR}/usr/share/jarvis/.zdirs
chmod 666 ${DESTDIR}/usr/share/jarvis/.zdirs
install -v -m 444 zshrc ${DESTDIR}/usr/share/jarvis/.zshrc
install -d -v ${DESTDIR}/usr/share/jarvis/funcs.d
install -v -m 444 funcs.d/* ${DESTDIR}/usr/share/jarvis/funcs.d
install -v -m 444 README.md img/* ${DESTDIR}/usr/share/jarvis/
install -D -v jarvis ${DESTDIR}/usr/bin/jarvis