#!/bin/bash

set -e -o pipefail

echo ":bazel: Building FlappyKite with Bazel"
bazelisk build //FlappyKite:FlappyKite

TOKEN=$(buildkite-agent oidc request-token --audience "https://packages.buildkite.com/buildkite/flappykite" --lifetime 300)

FILE=$(bazelisk cquery //FlappyKite:FlappyKite --output=files --ui_event_filters=-info --noshow_progress)
FILE=$(realpath $FILE)
if [ ! -f "$FILE" ]; then
    echo "Error: File $FILE does not exist."
    exit 1
fi
echo ":arrow_up: Uploading IPA to Buildkite Packages"
echo "IPA file: $FILE"
curl -X POST https://api.buildkite.com/v2/packages/organizations/buildkite/registries/flappykite/packages \
     -H "Authorization: Bearer $TOKEN" \
     -F "file=@$FILE"