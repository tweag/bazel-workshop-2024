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
