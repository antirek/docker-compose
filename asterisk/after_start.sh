#!/bin/bash


sleep 60

asterisk

asterisk -rx "module reload pbx_lua.so"

tail -f /var/log/asterisk/messages