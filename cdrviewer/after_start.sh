#!/bin/bash

export VIOLA_CDR_CONFIG=/etc/violacdr/config

sleep 30

chmod +x /tmp/viola-cdr/app.js

node /tmp/viola-cdr/app.js