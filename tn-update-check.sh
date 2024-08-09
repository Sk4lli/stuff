#!/bin/bash

# Vars
#

ntfy='<server>'
ntfy_topic='<topic>'
title='<title>'
message='<message>'
prio='<priority>' # Min/low/default/high/urgent

#
#

# The command to check for updates
upcheck='/usr/local/bin/freenas-update check'

# Run with sudo if we're not root
if (( EUID ))
then
    SUDO='/usr/local/bin/sudo'
fi

# Run the command and:
#  - Dump all output
#  - check the exit status:
#     0 = updates available
#     1 = no updates
if $SUDO $upcheck > /dev/null 2>&1
then
    curl -H "Title: $title" -H "Priority: $prio" -d "$message" "$ntfy/$ntfy_topic"
    exit 1
else
    echo 'OK: No updates available.'
    exit 0
fi
