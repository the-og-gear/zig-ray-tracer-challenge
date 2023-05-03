// Unit tests for the canvas
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
const C = @import("src").canvas;
const T = @import("src").tuples;
const std = @import("std");

test "creating a canvas" {
    const canvas = C.canvas(10, 20);

    try std.testing.expect(canvas.width == 10 and canvas.height == 20);
    for (canvas.pixels) |color| {
        try std.testing.expect(T.equal_tuple(T.color(0, 0, 0), color));
    }
}

test "writing pixels to canvas" {
    var canvas = C.canvas(10, 20);
    const red = T.color(1, 0, 0);

    C.write_pixel(canvas, 2, 3, red);
    try std.testing.expect(T.equal_tuple(C.pixel_at(canvas, 2, 3), red));
}
