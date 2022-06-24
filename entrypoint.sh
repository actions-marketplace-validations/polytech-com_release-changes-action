#!/bin/bash
set -e

GITHUB_SHA=$1
GITHUB_REF_NAME=$2

if [[ $GITHUB_REF_NAME == */merge ]]; then
  RELEASE_CHANGES=0
  echo "Workflow is a pull request. Setting changes to false"
  echo ::set-output name=changes::false
else
  RELEASE_LATEST=$(git tag --sort committerdate --merged "$GITHUB_REF_NAME" | tail -1)
  RELEASE_CHANGES=$(git log --pretty=%h "$RELEASE_LATEST..$GITHUB_SHA" | wc -l)
  echo "Found $RELEASE_CHANGES change(s) for commit $GITHUB_SHA on $GITHUB_REF_NAME"
  if [[ $RELEASE_CHANGES -gt 0 ]]; then
    echo ::set-output name=changes::true
  else
    echo ::set-output name=changes::false
  fi
fi
