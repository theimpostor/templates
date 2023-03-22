#!/usr/bin/env bash

set -o errexit -o errtrace -o pipefail -o nounset
function die() {
    local frame=0
    >&2 echo "died. backtrace:"
    while caller $frame; do ((++frame)); done
    exit 1
}
trap die ERR

# GLOBALS
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; readonly SCRIPT_DIR

# FUNCTIONS
function warn() {
    >&2 echo "$@"
}

function usage() {
    cat <<EOF
Usage: $0 [options] [--] [args]
options:
    --help, -h
        Print this message
    --debug, -d
        Enable debug tracing
    --
        Stop parsing options
EOF
}

# MAIN
while (($#)); do
    case $1 in
        --help|-h) usage; exit 0
            ;;
        --debug|-d) set -o xtrace
            ;;
        --) shift; break
            ;;
        -*) warn "Unrecognized argument: $1"; exit 1
            ;;
        *) break
            ;;
    esac; shift
done

if [ -t 1 ] ; then 
    echo Writing to terminal
else 
    echo Writing to file
fi

if (return 0 2>/dev/null) ; then
    echo Script is sourced
else
    echo Script is executed
fi

# # redirect output to file
# exec > >(tee "${LOG}")
# # tie stderr to stdout
# exec 2>&1

echo SCRIPT_DIR: "$SCRIPT_DIR"
echo args: "$@"

# vim:ft=bash:sw=4:ts=4:expandtab
