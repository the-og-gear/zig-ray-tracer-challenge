const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "Ray Tracing Challenge",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe.install();

    const run_cmd = exe.run();

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const src_module = b.createModule(.{
        .source_file = .{ .path = "src/main.zig" },
    });
    const exe_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/tests/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe_tests.addModule("src", src_module);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}