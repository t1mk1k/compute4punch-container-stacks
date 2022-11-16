#!/bin/bash

echo "executing script display.sh" > /tmp/condor_display.log

if [ -r /srv/.display ]; then
  source /srv/.display
  rm -f /srv/.display
fi
