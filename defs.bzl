load("//build/kernel/kleaf:kernel.bzl", "kernel_module")

def aml_w2_module(name, kernel_build, deps = None):
    kernel_module(
        name = name,
        srcs = ["//vendor/amlogic/amlogic-drivers/w2:w2_srcs"],
        makefile = ["//vendor/amlogic/amlogic-drivers/w2:Makefile"],
        deps = deps,
        outs = [
            "w2.ko",
            "w2_comm.ko",
        ],
        kernel_build = kernel_build,
    )
