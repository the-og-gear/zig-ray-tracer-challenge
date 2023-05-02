// The main entry point of the program. This file varies by iteration with its purpose.
// Copyright (C) 2023 Gear
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

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
