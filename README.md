# Release Changes

![GitHub release (latest by date)](https://img.shields.io/github/v/release/polytech-com/release-changes-action) ![GitHub](https://img.shields.io/github/license/polytech-com/release-changes-action)

GitHub Actions for checking changes between releases.

Changes are found by looking at new commits from the last tag on the workflow branch. This can be helpful for skipping upload of nightly builds etc. and an alternative to always uploading on push.

## Usage

Below is an example of skipping upload of releases to GitHub for sheduled builds and workflow dispatch triggers when no new commits have been added since last release. Pull requests will always indicate no changes.

```yml
name: ci

on:
  workflow_dispatch:
  schedule:
    - cron: '0 18 * * 1-5'
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Build
        run: ./build.sh
      - name: Check release changes
        uses: polytech-com/release-changes-action@v0.4
        id: release
      - name: Upload to GitHub
        uses: softprops/action-gh-release@v1
        if: ${{ steps.release.outputs.changes == 'true' }}
        with:
          target_commitish: ${{ github.sha }}
```

## Inputs

The following input values are supported and can be changed if needed.

| Name | Type | Description | Default value |
| --- | --- | --- | --- |
| `sha` | `string` | The commit SHA that triggered the workflow run | `${{ github.sha }}` |
| `ref_name` | `string` | The branch or tag name that triggered the workflow run | `${{ github.ref_name }}` |
