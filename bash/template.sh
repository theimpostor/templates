#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
# debug
# set -o xtrace

set -eu -o pipefail

# GLOBALS
readonly SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# FUNCTIONS
function usage() {
    cat <<EOF
Usage: $0 [options]
options:
    --help, -h
        Print this message
EOF
}

function warn() {
    >&2 echo "$@"
}

function die() {
    warn "$@"
    exit 1
}

function exiterr {
    die "An error occurred"
}

# MAIN
while (($#)); do
    case $1 in
        --help|-h)
            usage
            exit 0
            ;;
        --)
            shift;
            break;
            ;;
        * )
            warn "Unrecognized argument: $1"
            die "$(usage)"
            ;;
    esac
    shift
done

trap exiterr EXIT

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

echo SCRIPT_DIR: "$SCRIPT_DIR"
echo args: "$@"

trap - EXIT