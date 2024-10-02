def cc_library(**attrs):
    if "copts" in attrs.keys():
        fail("{} is setting copts".format(attrs["name"]))
    attrs["copts"] = ["-std=c++17"]
    native.cc_library(**attrs)

def cc_binary(**attrs):
    if "copts" in attrs.keys():
        fail("{} is setting copts".format(attrs["name"]))
    attrs["copts"] = ["-std=c++17"]
    native.cc_binary(**attrs)
