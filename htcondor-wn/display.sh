#!/bin/bash

echo "executing script display.sh" > /tmp/condor_display.log

if [ -r /srv/.display ]; then
  echo "/srv/.display present" >> /tmp/condor_display.log
  source /srv/.display
  rm -f /srv/.display
else
  echo "/srv/.display NOT present" >> /tmp/condor_display.log
fi
