const std = @import("std");
pub const tuples = @import("tuples.zig");

const Projectile = struct { position: tuples.Tuple, velocity: tuples.Tuple };
const Environment = struct { gravity: tuples.Tuple, wind: tuples.Tuple };

pub fn main() !void {
    var projectile = Projectile{ .position = tuples.point(0, 1, 0), .velocity = tuples.normalize(tuples.vector(1, 1.1, 0)) };
    var environment = Environment{ .gravity = tuples.vector(0, -0.1, 0), .wind = tuples.vector(-0.01, 0, 0) };

    while (projectile.position.y >= 0) {
        projectile = tick(environment, projectile);
    }

    try std.io.getStdOut().writer().print("Projectile X distance: {}", .{projectile.position.x});
}

fn tick(env: Environment, proj: Projectile) Projectile {
    var p = Projectile{ .position = tuples.vector(0, 0, 0), .velocity = tuples.vector(0, 0, 0) };
    p.position = tuples.add_tuple(proj.position, proj.velocity); //proj.position + proj.velocity;
    p.velocity = tuples.add_tuple(proj.velocity, tuples.add_tuple(env.gravity, env.wind)); //proj.velocity + env.gravity + env.wind;
    return p;
}
