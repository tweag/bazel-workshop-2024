#!/usr/bin/env bash

docker build -t bazel_workshop_devcontainer .

docker run -it \
    -v ".:/workspaces/bazel-workshop-2024:z" \
    --workdir /workspaces/bazel-workshop-2024 \
    bazel_workshop_devcontainer
