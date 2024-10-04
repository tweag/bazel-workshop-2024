#!/usr/bin/env bash

docker build -t bazel_workshop_devcontainer .

docker run -it \
   --privileged \
    -v ".:/workspaces/bazel-workshop-2024:z" \
    --workdir /workspaces/bazel-workshop-2024 \
   --mount type=volume,source=bazel_workshop_env_command_history,target=/command_history \
   --mount type=volume,source=bazel_workshop_env_bazel_cache,target=/bazel_cache \
    bazel_workshop_devcontainer
