#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
# debug
# set -o xtrace

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
    # dump a stack trace
    local frame=0
    while caller $frame; do
        # prefix increment to prevent set -e from exiting when frame=0
        ((++frame))
    done
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
        -* )
            warn "Unrecognized argument: $1"
            die "$(usage)"
            ;;
        *)
            shift;
            break;
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

# # redirect output to file
# exec > >(tee "${LOG}")
# # tie stderr to stdout
# exec 2>&1

echo SCRIPT_DIR: "$SCRIPT_DIR"
echo args: "$@"

trap - EXIT
