#!/usr/bin/env bash

docker pull ghcr.io/tweag/bazel-workshop-2024:latest

docker run -it \
   --privileged \
   -e force_color_prompt=yes \
   -v ".:/workspaces/bazel-workshop-2024:z" \
    --workdir /workspaces/bazel-workshop-2024 \
   --mount type=volume,source=bazel_workshop_env_command_history,target=/command_history \
   --mount type=volume,source=bazel_workshop_env_bazel_cache,target=/bazel_cache \
    ghcr.io/tweag/bazel-workshop-2024:latest
