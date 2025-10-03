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

# I *should* be able to run:
#       bazel build //example:ConditionalAggregate --//example:FilesToInclude=FileB,FileA
# according to: https://bazel.build/reference/be/general#:~:text=values%20=%20{%20%22myflag%22:%20%22a%2Cb%22%20}%20works%20the%20same%20way:%20this%20matches%20%2D%2Dmyflag=a%20%2D%2Dmyflag=b%2C%20%2D%2Dmyflag=a%20%2D%2Dmyflag=b%20%2D%2Dmyflag=c%2C%20%2D%2Dmyflag=a%2Cb%2C%20and%20%2D%2Dmyflag=c%2Cb%2Ca.
# But I get the error:
#        $ bazel build //example:ConditionalAggregate --//example:FilesToInclude=FileB,FileA
#        ERROR: /tmp/Projects/bazelExample/example/BUILD:62:14: Illegal ambiguous match on configurable attribute "srcs" in //example:ConditionalAggregate:
#        //example:FileAIncluded
#        //example:FileBIncluded
#        Multiple matches are not allowed unless one is unambiguously more specialized or they resolve to the same value. See https://bazel.build/reference/be/functions#select.
#        ERROR: Analysis of target '//example:ConditionalAggregate' failed; build aborted
#        INFO: Elapsed time: 0.056s, Critical Path: 0.00s
#        INFO: 1 process: 1 internal.
#        ERROR: Build did NOT complete successfully
