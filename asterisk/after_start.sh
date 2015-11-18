#!/bin/bash

ln -s /tmp/lua-dialplan/ /usr/local/lib/lua/5.1/dialplan

rm -f -v /etc/asterisk/extensions.lua
ln -s /tmp/lua-dialplan/extensions.lua /etc/asterisk/extensions.lua

asterisk

sleep 1

asterisk -rvvvvvvv