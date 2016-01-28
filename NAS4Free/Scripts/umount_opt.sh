#!/bin/bash

# author: the-razer on nas4free.org forums
# last update: 13.09.12
#
# unmount unionfs so that you
# install software even with
# an embedded install

umount -t unionfs -f /var/db
umount -t unionfs -f /usr/local
