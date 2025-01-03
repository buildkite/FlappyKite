#!/usr/bin/env bash

set -euo pipefail

nsc bazel cache setup --bazelrc=/tmp/bazel-cache.bazelrc

bazelisk build --bazelrc=.bazelrc --bazelrc=/tmp/bazel-cache.bazelrc //FlappyKite:FlappyKite
