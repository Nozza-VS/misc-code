#!/bin/sh

export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"
export PATH=".:$PATH"
cd "$(dirname "${0}")"
/usr/sbin/daemon -f -p ts3server.pid ts3server_freebsd_x86 $@
