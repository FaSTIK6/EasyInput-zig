const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const pack_mod = b.addModule("easy_input", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/EasyInput.zig"),
    });

    const main_tests = b.addTest(.{
        .root_module = pack_mod,
    });

    const run_main_tests = b.addRunArtifact(main_tests);
    const test_step = b.step("test", "Run my tests");
    test_step.dependOn(&run_main_tests.step);
}
