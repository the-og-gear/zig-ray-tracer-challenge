// Tuple unit tests
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
const T = @import("src").tuples;

test "a tuple with w=1.0 is a point" {
    const a = T.point(4.3, -4.2, 3.1);

    try std.testing.expect(T.is_point(a));
}

test "a tuple with w=0.0 is a vector" {
    const a = T.vector(4.3, -4.2, 3.1);

    try std.testing.expect(T.is_vector(a));
}

test "add two tuples" {
    const a = T.point(3, -2, 5);
    const b = T.vector(-2, 3, 1);

    const c = T.point(1, 1, 6);
    try std.testing.expect(T.equal_tuple(T.add_tuple(a, b), c));
}

test "subtract two points" {
    const a = T.point(3, 2, 1);
    const b = T.point(5, 6, 7);

    const c = T.vector(-2, -4, -6);
    try std.testing.expect(T.equal_tuple(T.subtract_tuple(a, b), c));
}

test "subtract a vector from a point" {
    const a = T.point(3, 2, 1);
    const b = T.vector(5, 6, 7);

    const c = T.point(-2, -4, -6);
    try std.testing.expect(T.equal_tuple(T.subtract_tuple(a, b), c));
}

test "subtract two vectors" {
    const a = T.vector(3, 2, 1);
    const b = T.vector(5, 6, 7);

    const c = T.vector(-2, -4, -6);
    try std.testing.expect(T.equal_tuple(T.subtract_tuple(a, b), c));
}

test "subtract a vector from the zero vector" {
    const a = T.vector(1, -2, 3);
    const zero = T.vector(0, 0, 0);

    const c = T.vector(-1, 2, -3);
    try std.testing.expect(T.equal_tuple(T.subtract_tuple(zero, a), c));
}

test "negate a tuple" {
    const a = T.tuple(1, -2, 3, -4);

    const c = T.tuple(-1, 2, -3, 4);
    try std.testing.expect(T.equal_tuple(T.negate_tuple(a), c));
}

test "multiply tuples by scalar" {
    const a = T.tuple(1, -2, 3, -4);
    const b = 3.5;

    const c = T.tuple(3.5, -7, 10.5, -14);
    try std.testing.expect(T.equal_tuple(T.multiply_tuple(a, b), c));
}

test "multiply tuples by fraction" {
    const a = T.tuple(1, -2, 3, -4);
    const b = 0.5; // 1/2

    const c = T.tuple(0.5, -1, 1.5, -2);
    try std.testing.expect(T.equal_tuple(T.multiply_tuple(a, b), c));
}

test "divide tuples by scalar" {
    const a = T.tuple(1, -2, 3, -4);
    const b = 2;

    const c = T.tuple(0.5, -1, 1.5, -2);
    try std.testing.expect(T.equal_tuple(T.divide_tuple(a, b), c));
}

fn fEq(a: f32, b: f32) bool {
    return std.math.approxEqAbs(f32, a, b, std.math.f32_epsilon);
}
fn fSqrt(a: anytype) f32 {
    return std.math.sqrt(@floatCast(f32, a));
}

test "compute magnitude of vector(1,0,0)" {
    const a = T.vector(1, 0, 0);
    try std.testing.expect(fEq(T.magnitude(a), 1));
}

test "compute magnitude of vector(0,1,0)" {
    const a = T.vector(0, 1, 0);
    try std.testing.expect(fEq(T.magnitude(a), 1));
}

test "compute magnitude of vector(0,0,1)" {
    const a = T.vector(0, 0, 1);
    try std.testing.expect(fEq(T.magnitude(a), 1));
}

test "compute magnitude of vector(1,2,3)" {
    const a = T.vector(1, 2, 3);
    try std.testing.expect(fEq(T.magnitude(a), fSqrt(14)));
}

test "compute magnitude of vector(-1,-2,-3)" {
    const a = T.vector(-1, -2, -3);
    try std.testing.expect(fEq(T.magnitude(a), fSqrt(14)));
}

test "normalizing vector(4, 0, 0) gives (1, 0, 0)" {
    const a = T.vector(4, 0, 0);
    const b = T.vector(1, 0, 0);
    try std.testing.expect(T.equal_tuple(T.normalize(a), b));
}

test "normalizing vector(1, 2, 3)" {
    const a = T.vector(1, 2, 3);
    const b = T.vector(1 / fSqrt(14), 2 / fSqrt(14), 3 / fSqrt(14));

    try std.testing.expect(T.equal_tuple(T.normalize(a), b));
}

test "the dot product of two tuples" {
    const a = T.vector(1, 2, 3);
    const b = T.vector(2, 3, 4);

    try std.testing.expect(fEq(T.dot(a, b), @floatCast(f32, 20)));
}

test "the cross product of two vectors" {
    const a = T.vector(1, 2, 3);
    const b = T.vector(2, 3, 4);

    const c = T.vector(-1, 2, -1);
    const d = T.vector(1, -2, 1);

    try std.testing.expect(T.equal_tuple(T.cross(a, b), c));
    try std.testing.expect(T.equal_tuple(T.cross(b, a), d));
}

test "color is aliased to tuple" {
    const c = T.color(-0.5, 0.4, 1.7);

    const r = T.tuple(-0.5, 0.4, 1.7, 0.0);
    try std.testing.expect(T.equal_tuple(c, r));
}
