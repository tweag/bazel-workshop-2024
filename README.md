# Introductory workshop for Bazel

## The code base

This is the Cookie Machine project. It implements a simple HTTP API for ordering
cookies, and querying the status of a cookie order. It consists of a client
written in C, a server written in C++, and a simple integration test to
demonstrate use of the API.

The actual code here _does not matter_. It only serves as an example code base
which we can build with Bazel.

## Use the devcontainer inside VS Code

Start VS Code in this project directory. VS Code should automatically recognize
the devcontainer configuration from `.devcontainer/devcontainer.json` and offer
to start the project inside the devcontainer. Accept this. Once the devcontainer
is started (there is a "Dev Container" log/terminal where you can watch its
progress), you can then open a bash terminal inside VS Code to navigate and run
commands inside the devcontainer. Skip to the section following the next to
verify that you have a working development environment.

## Run the devcontainer outside VS Code

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

## Devcontainer Compatibility

The devcontainer is built for the linux/amd64 platform. To use it, your
container runtime (i.e. Docker, Podman or similar) must be able to run
linux/amd64 container images. More resource on this:

- How to run amd64 docker image on arm64 host platform:
  https://stackoverflow.com/questions/67458621/how-to-run-amd64-docker-image-on-arm64-host-platform
- Colima: https://github.com/abiosoft/colima
- Get started with Docker remote containers on WSL 2:
  https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-containers
- More about running containers on WSL:
  https://makayppe.medium.com/docker-desktop-alternatives-when-its-no-longer-free-to-use-b3725538b597

If you have problems running the prepared devcontainer, you may have a go at
building you own (you might also have to make changes to the `Dockerfile`):

```cmd
./build-and-enter-docker.sh
```
