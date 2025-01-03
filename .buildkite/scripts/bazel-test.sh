#!/usr/bin/env bash

set -euo pipefail

nsc bazel cache setup --bazelrc=/tmp/bazel-cache.bazelrc

bazelisk test --bazelrc=.bazelrc --bazelrc=/tmp/bazel-cache.bazelrc //FlappyKiteTests:FlappyKiteTests //FlappyKiteUITests:FlappyKiteUITests
