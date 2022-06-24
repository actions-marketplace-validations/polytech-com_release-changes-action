#!/bin/bash
set -e

GITHUB_SHA=$1
GITHUB_REF_NAME=$2

if [[ $GITHUB_REF_NAME == */merge ]]; then
  RELEASE_CHANGES=0
  echo "Workflow is a pull request. Setting changes to false"
else
  RELEASE_LATEST=$(git tag --sort committerdate --merged "$GITHUB_REF_NAME" | tail -1)
  RELEASE_CHANGES=$(git log --pretty=%h "$RELEASE_LATEST..$GITHUB_SHA" | wc -l)
  echo "Found $RELEASE_CHANGES changes for commit $GITHUB_SHA on $GITHUB_REF_NAME"
fi

echo ::set-output name=changes::$((RELEASE_CHANGES > 0))
