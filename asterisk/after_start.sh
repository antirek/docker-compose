#!/bin/bash

asterisk

sleep 20

asterisk -rx "module reload pbx_lua.so"

tail -f /var/log/asterisk/messages