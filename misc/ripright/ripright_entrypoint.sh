#!/usr/bin/env sh
#
# Original credit: Jakub Skałecki
#   https://rock-it.pl/how-to-write-excellent-dockerfiles/
#
# $0 is a script name,
# $1, $2, $3 etc are passed arguments
# $1 is our command
CMD=$1

case "$CMD" in
    # Releases with a single match in MusicBrainz database
  "single" )
    exec ripright -o "%b/%D/%N %T.flac" &
    ;;

    # Releases with multiple matches in MusicBrainz database
  "multi" )
    exec ripright -a -o "%b/%D/%N %T.flac" &
    ;;

   * )
    exec $CMD ${@:2}
    ;;
esac
