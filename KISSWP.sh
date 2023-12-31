#!/bin/sh -f
#
# POSIX sh background setter

img(){
    [ -d "$1" ] && {
        set +f
        set -f -- "$1/"*
        shift "$(shuf -i "1-$#" -n 1)"
    }
    [ -f "${img:=$1}" ] || exit 1

    printf '%s\n' "$img"
}
main() {
#    mkdir -p "${cache_dir:=${XDG_CACHE_HOME:=${HOME}/.cache}/bud}"
    img "$1"
    display \
        -page 3200x \
        -sample 3200x \
        -window root \
        "$img" &
}
main "$1"
