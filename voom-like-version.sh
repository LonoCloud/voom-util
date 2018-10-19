#!/usr/bin/env bash

set -e

[ -n "$DEBUG" ] && set -x

voom_version() {
    echo $(date --date="$(git log -1 --pretty=%ci -- "$@")" "+%Y%m%d_%H%M%S")-g$(git log -1 --pretty=%h -- "$@")$(test -z "$(git status --short -- "$@")" || echo _DIRTY)
}

usage() {
    echo >&2 "usage: $0 <PATH> [PATH...] # Optionally, set REPO_ROOT_VOOM instead of supplying <PATH>."
    exit 1
}


if [ -z "$*" ]; then
    if [ "$REPO_ROOT_VOOM" ]; then
        voom_version
    else
        usage
    fi
else
    if [ "$REPO_ROOT_VOOM" ]; then
        usage
    else
        voom_version "$@"
    fi
fi
