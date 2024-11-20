load("@rules_cc//cc:defs.bzl", orig_cc_library = "cc_library", orig_cc_binary = "cc_binary")

def cc_library(**attrs):
    if "copts" in attrs.keys():
        fail("{} is setting copts".format(attrs["name"]))
    attrs["copts"] = ["-std=c++17"]
    orig_cc_library(**attrs)

def cc_binary(**attrs):
    if "copts" in attrs.keys():
        fail("{} is setting copts".format(attrs["name"]))
    attrs["copts"] = ["-std=c++17"]
    orig_cc_binary(**attrs)
