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

Run the following command from the root of the repository:

```cmd
./enter-docker.sh
```

## Verify working development environment

Run this command inside the docker container to verify that you have a working
development environment:

```cmd
bazel --version
```

This should report back `bazel 7.3.1`.
