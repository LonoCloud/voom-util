#!/usr/bin/env bash

set -e

[ -n "$DEBUG" ] && set -x

if [ -z "$*" ]; then
    echo >&2 "usage: $0 <PATH> [PATH...]"
    exit 1
fi

echo $(date --date="$(git log -1 --pretty=%ci -- "$@")" "+%Y%m%d_%H%M%S")-g$(git log -1 --pretty=%h -- "$@")$(test -z "$(git status --short -- "$@")" || echo _DIRTY)
