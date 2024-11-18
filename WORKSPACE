workspace(name = "cookie_machine")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# rules_cc
http_archive(
    name = "rules_cc",
    url = "https://github.com/bazelbuild/rules_cc/releases/download/0.0.10/rules_cc-0.0.10.tar.gz",
    integrity = "sha256-ZbZ7gcbaN48TbMfn4U7gjVuTdZc0J+zrjHc6T2n6fkk=",
    strip_prefix = "rules_cc-0.0.10",
)


# rules_foreign_cc
http_archive(
    name = "rules_foreign_cc",
    url = "https://github.com/bazelbuild/rules_foreign_cc/releases/download/0.12.0/rules_foreign_cc-0.12.0.tar.gz",
    integrity = "sha256-oub7VuZJwe55cD6ZqgydE8bMU8jXoMu4eXqyiIu8maM=",
    strip_prefix = "rules_foreign_cc-0.12.0",
)

load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

rules_foreign_cc_dependencies(
    register_built_tools = False,
)

load("@bazel_features//:deps.bzl", "bazel_features_deps")

bazel_features_deps()


# openssl
http_archive(
    name = "openssl",
    url = "https://www.openssl.org/source/old/1.1.1/openssl-1.1.1w.tar.gz",
    integrity = "sha256-zzCYlQy02FOtlcCEHx+cbT3BAtzPys1SHZOSUgi3asg=",
    strip_prefix = "openssl-1.1.1w",
    build_file_content = """
load("@rules_foreign_cc//foreign_cc:configure.bzl", "configure_make")

filegroup(
    name = "openssl_srcs",
    srcs = glob(["**"]),
)

configure_make(
    name = "openssl",
    args = [" -j `nproc`"],
    configure_command = "Configure",
    configure_options = [
        "no-async",
        "no-hw-padlock",
        "no-capieng",
        "linux-x86_64",
    ],
    lib_source = ":openssl_srcs",
    out_static_libs = [
        "libssl.a",
        "libcrypto.a",
    ],
    visibility = ["//visibility:public"],
)
    """,
)


# curl
http_archive(
    name = "curl",
    url = "https://curl.se/download/curl-7.77.0.tar.gz",
    integrity = "sha256-sKNCistg+lkETE0LquTk/AmumvHYo6qEsuP7zZmEH3c=",
    strip_prefix = "curl-7.77.0",
    build_file_content = """
load("@rules_foreign_cc//foreign_cc:defs.bzl", "cmake")

filegroup(
    name = "curl_srcs",
    srcs = glob(["**"]),
)

cmake(
    name = "curl",
    build_args = [" -j `nproc`"],
    cache_entries = {
        "BUILD_CURL_EXE": "off",
        "BUILD_SHARED_LIBS": "off",
        "CMAKE_PREFIX_PATH": ";$EXT_BUILD_DEPS/openssl",
        "CURL_DISABLE_LDAP": "on",
    },
    lib_source = ":curl_srcs",
    out_static_libs = ["libcurl.a"],
    deps = ["@openssl"],
    visibility = ["//visibility:public"],
)
    """,
)

# llvm toolchain
http_archive(
    name = "toolchains_llvm",
    sha256 = "e3fb6dc6b77eaf167cb2b0c410df95d09127cbe20547e5a329c771808a816ab4",
    strip_prefix = "toolchains_llvm-v1.2.0",
    canonical_id = "v1.2.0",
    url = "https://github.com/bazel-contrib/toolchains_llvm/releases/download/v1.2.0/toolchains_llvm-v1.2.0.tar.gz",
)

load("@toolchains_llvm//toolchain:deps.bzl", "bazel_toolchain_dependencies")

bazel_toolchain_dependencies()

load("@toolchains_llvm//toolchain:rules.bzl", "llvm_toolchain")

llvm_toolchain(
    name = "llvm_toolchain",
    llvm_version = "17.0.6",
)

load("@llvm_toolchain//:toolchains.bzl", "llvm_register_toolchains")

llvm_register_toolchains()

# asio
http_archive(
    name = "asio",
    url = "https://downloads.sourceforge.net/asio/asio-1.30.2.tar.gz",
    integrity = "sha256-Eue7Ta2ovBGR3p1VClnuZYzk5kX/yXyRHAmatOhpnVU=",
    strip_prefix = "asio-1.30.2/",
    build_file_content = """
load("@rules_cc//cc:defs.bzl", "cc_library")
cc_library(
    name = "asio",
    hdrs = glob(["include/**/*.h", "include/**/*.hpp", "include/**/*.ipp"]),
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
    """,
)
