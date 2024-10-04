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
