# Introductory workshop for Bazel

## Use the devcontainer inside VS Code

Start VS Code in this project directory. VS Code should automatically recognize
the devcontainer configuration from `.devcontainer/devcontainer.json` and offer
to start the project inside the devcontainer. Accept this. Once the devcontainer
is started (there is a "Dev Container" log/terminal where you can watch its
progress), you can then open a bash terminal inside VS Code to navigate and run
commands inside the devcontainer. Skip to the section following the next to
verify that you have a working development environment.

## Build and run the devcontainer outside VS Code

First build the devcontainer:

```cmd
docker build -t bazel_workshop_devcontainer .
```

The run it like this:

```cmd
docker run -it \
    -v ".:/workspaces/bazel-workshop-2024:z" \
    --workdir /workspaces/bazel-workshop-2024 \
    bazel_workshop_devcontainer
```

## Verify working development environment

Run these commands inside that termainal to verify that you have a working
development environment:

```cmd
cd project1
bazel --version
```

This should report back `bazel 7.3.1`.

In total it should look something like this:

```
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@d533a5ea7d39:/workspaces/bazel-workshop-2024$ cd project1/
ubuntu@d533a5ea7d39:/workspaces/bazel-workshop-2024/project1$ bazel --version
2024/09/30 09:08:34 Downloading https://releases.bazel.build/7.3.1/release/bazel-7.3.1-linux-x86_64...
Downloading: 68 MB out of 68 MB (100%)
bazel 7.3.1
```
