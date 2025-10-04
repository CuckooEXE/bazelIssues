load("@bazel_skylib//rules:common_settings.bzl", "string_list_flag")
load("//example:defs.bzl", "aggregate_txt", "all_possible_files", "generate_selects")

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
    build_setting_default = all_possible_files.keys(),
)

# Example of a manual use of the rule
aggregate_txt(
    name = "ManualAggregate",
    srcs = [
        ":FileA",
        ":FileB",
    ],
)

# Run `bazel build //example:ConditionalAggregate --//example:FilesToInclude=FileB` for example
aggregate_txt(
    name = "ConditionalAggregate",
    srcs = generate_selects(),
)
