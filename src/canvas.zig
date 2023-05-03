// The Canvas and relevant functions
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

const tuples = @import("tuples.zig");
const std = @import("std");

// Allocate a decently large buffer for pixels
var pixel_bytes: [16 * 1024]tuples.Tuple = undefined;

pub const Canvas = struct {
    width: u32,
    height: u32,
    pixels: []tuples.Tuple,
};

pub fn canvas(width: u32, height: u32) Canvas {
    var C = Canvas{ .width = width, .height = height, .pixels = pixel_bytes[0..] };
    var index: u32 = 0;
    while (index < C.width * C.height) : (index += 1) {
        C.pixels[index] = tuples.color(0, 0, 0);
    }
    return C;
}

pub fn write_pixel(c: Canvas, x: u32, y: u32, color: tuples.Tuple) void {
    c.pixels[@as(usize, (x + y * c.width))] = color;
}

pub fn pixel_at(c: Canvas, x: u32, y: u32) tuples.Tuple {
    return c.pixels[@as(usize, (x + y * c.width))];
}
