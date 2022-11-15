#!/bin/bash

if [ -r /srv/.display ]; then
  source /srv/.display
  rm -f /srv/.display
fi
