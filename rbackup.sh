#!/bin/bash
rsync -av --exclude-from=/var/local/ignorelist  -e ssh /home/* Whit@192.168.68.254::NetBackup/AORUS/daily > /home/whit/.local/rbackup.log

