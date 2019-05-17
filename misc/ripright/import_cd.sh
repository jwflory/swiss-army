#!/usr/bin/bash
#
# $0 is a script name,
# $1, $2, $3 etc are passed arguments
# $1 is our command

export BASE_CMD="sudo podman run --privileged -v $HOME/wkspc/:/root/Music/:z -v /dev/sr1:/dev/cdrom:Z --rm -it"
CMD=$1

echo -e '\nsudo password required to reset user ownership of $HOME/wkspc\n'
sudo chown -R $USER:$USER $HOME/wkspc
case "$CMD" in
    # Releases with a single match in MusicBrainz database
  "single" )
    $BASE_CMD ripright-single
    chown -R $USER:$USER $HOME/wkspc
    ;;

    # Releases with multiple matches in MusicBrainz database
  "multi" )
    $BASE_CMD ripright-multi
    chown -R $USER:$USER $HOME/wkspc
    ;;

   * )
    exec $CMD ${@:2}
    ;;
esac
