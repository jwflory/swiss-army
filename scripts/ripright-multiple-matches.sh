#!/usr/bin/bash
#
# Script to rip a CD in the CD drive to FLAC and save it to my library in the
# preferred naming scheme. Runs until terminated.
#
# This command works for CDs that return multiple matches.
#

ripright -c /dev/sr1 -a -o "%b/%D/%N %T.flac"

