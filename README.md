# Release Changes 

GitHub Actions for checking changes between releases.

Changes are found by looking at new commits from the last tag on the workflow branch. This can be helpful for skipping upload of nightly builds etc. and an alternative to always uploading on push.

## Usage

```yml
    - name: Check for release changes
      uses: polytech-com/release-changes-action@v0.4
      id: release
    - name: Upload to GitHub
      uses: softprops/action-gh-release@v1
      if: ${{ steps.release.outputs.changes == 'true' }}
      with:
        tag_name: ${{ env.RELEASE_VERSION }}
        prerelease: ${{ github.ref_name != 'main' }}
        files: release/*
        target_commitish: ${{ github.sha }}
        generate_release_notes: true
```

## Inputs

| Name | Description | Default value |
| --- | --- | --- |
| sha | The commit SHA that triggered the workflow run | ${{ github.sha }} |
| ref_name | The branch or tag name that triggered the workflow run | ${{ github.ref_name }} |
