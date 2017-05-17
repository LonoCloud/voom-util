#!/bin/bash

set -e

if ../voom-like-version.sh >/dev/null 2>/dev/null; then
    echo "Did not fail with zero arguments"
    exit 1
fi
