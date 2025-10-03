load("@bazel_skylib//rules:common_settings.bzl", "string_list_flag")
load("//example:defs.bzl", "aggregate_txt")

all_possible_files = {
    "FileA": ":FileA",
    "FileB": ":FileB",
    "FileC": ":FileC",
}

filegroup(
    name = "FileA",
    srcs = ["FileA.txt"],
)

filegroup(
    name = "FileB",
    srcs = ["FileB.txt"],
)

filegroup(
    name = "FileC",
    srcs = ["FileC.txt"],
)

string_list_flag(
    name = "FilesToInclude",
    # build_setting_default = [all_possible_files.keys()],
    build_setting_default = [],
)

config_setting(
    name = "FileAIncluded",
    flag_values = {
        ":FilesToInclude": "FileA",
    },
)

config_setting(
    name = "FileBIncluded",
    flag_values = {
        ":FilesToInclude": "FileB",
    },
)

config_setting(
    name = "FileCIncluded",
    flag_values = {
        ":FilesToInclude": "FileC",
    },
)

# Example of a manual use of the rule
aggregate_txt(
    name = "ManualAggregate",
    srcs = [
        ":FileA",
        ":FileB",
    ],
)

# Example of select working where I can choose one OR all files
# Run `bazel build //example:ConditionalAggregate --//example:FilesToInclude=FileB` for example
aggregate_txt(
    name = "ConditionalAggregate",
    srcs = select({
        ":FileAIncluded": [":FileA"],
        ":FileBIncluded": [":FileB"],
        ":FileCIncluded": [":FileC"],
    }),
)

# I *want* to be able to run
#        bazel build //example:ConditionalAggregate --//example:FilesToInclude=FileB,FileA
# And have the `select` statement automatically pull in `:FileA` and `:FileB`.
