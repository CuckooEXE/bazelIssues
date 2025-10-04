def _aggregate_txt_impl(ctx):
    output = ctx.actions.declare_file("aggregate.txt")

    ctx.actions.run_shell(
        inputs = ctx.files.srcs,
        outputs = [output],
        command = "cat {} > {}".format(" ".join([f.path for f in ctx.files.srcs]), output.path),
        mnemonic = "AggregateTxt",
    )
    return DefaultInfo(files = depset([output]))

aggregate_txt = rule(
    implementation = _aggregate_txt_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [".txt"]),
    },
)

all_possible_files = {
    "FileA": "FileA",
    "FileB": "FileB",
    "FileC": "FileC",
}

def generate_selects():
    selects = []
    for name, target in all_possible_files.items():
        native.config_setting(
            name = "{}Included".format(name),
            flag_values = {
                ":FilesToInclude": target,
            },
        )
        selects += select({
            ":{}Included".format(name): [target],
            "//conditions:default": [],
        })

    return selects
