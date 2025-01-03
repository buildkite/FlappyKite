#!/bin/bash

set -ex -o pipefail

SOURCE=${BASH_SOURCE[0]}

BUILDKITE_CACHE_MOUNT_PATH="${NSC_CACHE_PATH:-.cache/buildkite}"

sed \
    -e "s|__SENTRY_DSN_HOST_REPLACE__|$(buildkite-agent secret get sentry_dsn_host)|g" \
    -e "s|__SENTRY_DSN_PATH__|$(buildkite-agent secret get sentry_dsn_path)|g" \
    Config.xcconfig.template > Config.xcconfig

xcodebuild clean build -clonedSourcePackagesDirPath SwiftPackages CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO
