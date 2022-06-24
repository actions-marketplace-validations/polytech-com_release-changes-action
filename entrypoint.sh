#!/bin/bash
set -e

GITHUB_SHA=$1
GITHUB_REF_NAME=$2

echo "GITHUB_REF_NAME = $GITHUB_REF_NAME"

RELEASE_LATEST=$(git tag --sort committerdate --merged "$GITHUB_REF_NAME" | tail -1)
RELEASE_CHANGES=$(git log --pretty=%h "$RELEASE_LATEST..$GITHUB_SHA" | wc -l)

echo ::set-output name=changes::$((RELEASE_CHANGES > 0))
