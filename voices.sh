#!/bin/sh

########################################################################################
# The following script indefinitely uses each voice offered by the 'say' command       #
# and lets the user know they should lock their machine next time they're away         #
# from their computer.                                                                 #
# It makes sure the volume is always increased; so muting the computer will not help.  #
# This script will only work on a Mac Computer                                         #
########################################################################################

OSASCRIPT_CMD=osascript

command_exists() {
  command -v $1 > /dev/null 2>&1
}

# check whether osascript command exists on machine

if ! command_exists $OSASCRIPT_CMD; then
  echo >&2 "$OSASCRIPT_CMD command not found. Aborting..." 
  exit 1
fi

while (true); do

  say -v '?' | 
  awk '{print $1}' |
  for voice in `xargs -J {}` ; do 
    $OSASCRIPT_CMD -e "set volume 10"
    say -v $voice "Next time, remember to lock your machine!"
  done

  sleep 10

done

