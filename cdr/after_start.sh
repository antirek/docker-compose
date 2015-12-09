#!/bin/bash

service mysql start

sleep 20

tail -f /var/log/mysql/error.log