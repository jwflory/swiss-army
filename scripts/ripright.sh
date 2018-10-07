#!/usr/bin/bash
#
# Script to rip a CD in the CD drive to FLAC and save it to my library in the
# preferred naming scheme. Runs until terminated.
#

ripright -c /dev/sr1 -o "$HOME/Music/%b/%D/%N %T.flac"

