#!/bin/bash
set -e

GITHUB_SHA=$1
GITHUB_REF_NAME=$2
RELEASE_CHANGES=0

if [[ $GITHUB_REF_NAME != */merge ]]; then
  RELEASE_LATEST=$(git tag --sort committerdate --merged "$GITHUB_REF_NAME" | tail -1)
  RELEASE_CHANGES=$(git log --pretty=%h "$RELEASE_LATEST..$GITHUB_SHA" | wc -l)
fi

echo "Found $RELEASE_CHANGES changes for commit $GITHUB_SHA on $GITHUB_REF_NAME "
echo ::set-output name=changes::$((RELEASE_CHANGES > 0))
