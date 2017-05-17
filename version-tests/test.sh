#!/bin/bash

set -e

VLV=../voom-like-version.sh

echo "Running tests:"

if [  $(git rev-parse --show-cdup) != "../" ]; then
    echo -e >&2 "These tests rely on git history of the upstream repo \n"\
    "and will not work if modified or pulled into another repo (such as \n"\
    "with git subrepo)"
    exit 1
fi

echo "+ Running zero arg test"
if ${VLV} >/dev/null 2>/dev/null; then
    echo >&2 "Did not fail with zero arguments"
    exit 1
fi

early_ver=$(${VLV} test-files/earlier)
later_ver=$(${VLV} test-files/later)
both_ver=$(${VLV} test-files/earlier test-files/later)
reverse_ver=$(${VLV} test-files/later test-files/earlier)
dir_ver=$(${VLV} test-files/)
here_ver=$(cd test-files/ && ../${VLV} .)

function fail() {
    echo >&2 "^--- Failed at test ---^"
    exit 1
}

trap fail ERR

set -ex

[ "$later_ver" == "$both_ver" ]
[ "$later_ver" == "$reverse_ver" ]
[ "$later_ver" == "$dir_ver" ]
[ "$later_ver" == "$here_ver" ]
[ "$later_ver" != "$early_ver" ]

