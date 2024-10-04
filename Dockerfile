FROM ubuntu:24.04

ARG USERNAME=ubuntu
ARG DEBIAN_FRONTEND=noninteractive
ARG UID=1000

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
SHELL ["/bin/bash", "-c"]
USER root

RUN \
    apt-get update && \
    apt-get --assume-yes install --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        git-lfs \
        jq \
        less \
        libasio-dev \
        libcurl4-openssl-dev \
        libxml2 \
        make \
        nano \
        openssh-client \
        python3 \
        python3-pip  \
        sudo \
        unzip \
        zip

# Install bazelisk
RUN curl --compressed --fail --silent --show-error --location --output /usr/bin/bazel \
      "https://github.com/bazelbuild/bazelisk/releases/download/v1.21.0/bazelisk-linux-amd64" && \
    echo "655a5c675dacf3b7ef4970688b6a54598aa30cbaa0b9e717cd1412c1ef9ec5a7 /usr/bin/bazel" > /tmp/bazelisk.sha256sum && \
    sha256sum --check /tmp/bazelisk.sha256sum && \
    rm /tmp/bazelisk.sha256sum && \
    chmod +x /usr/bin/bazel

# Create the non-root user, with sudo privileges
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

ENTRYPOINT ["/bin/bash"]

RUN dpkg-reconfigure debconf -f noninteractive -p critical && \
    rm -f /etc/apt/apt.conf.d/docker-clean && \
    mkdir -p /home/${USERNAME}/.cache /home/${USERNAME}/.ssh && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

RUN mkdir /command_history
RUN mkdir /bazel_cache
RUN chown -R $UID:$UID /command_history
RUN chown -R $UID:$UID /bazel_cache

USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Pre-download Bazel via Bazelisk, also pre-download LLVM
COPY .bazelversion /tmp/.bazelversion
RUN <<EOF0
cat > "/tmp/WORKSPACE" <<EOF1
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "toolchains_llvm",
    sha256 = "e3fb6dc6b77eaf167cb2b0c410df95d09127cbe20547e5a329c771808a816ab4",
    strip_prefix = "toolchains_llvm-v1.2.0",
    canonical_id = "v1.2.0",
    url = "https://github.com/bazel-contrib/toolchains_llvm/releases/download/v1.2.0/toolchains_llvm-v1.2.0.tar.gz",
)
EOF1
cd /tmp/ && bazel sync --only=toolchains_llvm
EOF0
