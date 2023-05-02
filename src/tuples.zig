const std = @import("std");

pub fn is_point(a: Tuple) bool {
    return a.w == 1.0;
}

pub fn is_vector(a: Tuple) bool {
    return a.w == 0.0;
}

pub const Tuple = struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,
};

pub fn tuple(x: f32, y: f32, z: f32, w: f32) Tuple {
    return Tuple{ .x = x, .y = y, .z = z, .w = w };
}

pub fn point(x: f32, y: f32, z: f32) Tuple {
    return Tuple{ .x = x, .y = y, .z = z, .w = 1.0 };
}

pub fn vector(x: f32, y: f32, z: f32) Tuple {
    return Tuple{ .x = x, .y = y, .z = z, .w = 0.0 };
}

pub fn add_tuple(a: Tuple, b: Tuple) Tuple {
    return Tuple{ .x = a.x + b.x, .y = a.y + b.y, .z = a.z + b.z, .w = a.w + b.w };
}

pub fn equal_tuple(a: Tuple, b: Tuple) bool {
    const x = std.math.approxEqAbs(f32, a.x, b.x, std.math.f32_epsilon);
    const y = std.math.approxEqAbs(f32, a.y, b.y, std.math.f32_epsilon);
    const z = std.math.approxEqAbs(f32, a.z, b.z, std.math.f32_epsilon);
    const w = std.math.approxEqAbs(f32, a.w, b.w, std.math.f32_epsilon);
    return x and y and z and w;
}

pub fn subtract_tuple(a: Tuple, b: Tuple) Tuple {
    return Tuple{ .x = a.x - b.x, .y = a.y - b.y, .z = a.z - b.z, .w = a.w - b.w };
}

pub fn negate_tuple(a: Tuple) Tuple {
    return Tuple{ .x = -a.x, .y = -a.y, .z = -a.z, .w = -a.w };
}

pub fn multiply_tuple(a: Tuple, b: f32) Tuple {
    return Tuple{ .x = a.x * b, .y = a.y * b, .z = a.z * b, .w = a.w * b };
}

pub fn divide_tuple(a: Tuple, b: f32) Tuple {
    return tuple(a.x / b, a.y / b, a.z / b, a.w / b);
}

fn sqr(a: f32) f32 {
    return std.math.pow(f32, a, 2);
}

pub fn magnitude(a: Tuple) f32 {
    return std.math.sqrt(sqr(a.x) +
        sqr(a.y) +
        sqr(a.z) +
        sqr(a.w));
}

pub fn normalize(a: Tuple) Tuple {
    const mag = magnitude(a);
    return tuple(a.x / mag, a.y / mag, a.z / mag, a.w / mag);
}

pub fn dot(a: Tuple, b: Tuple) f32 {
    return a.x * b.x +
        a.y * b.y +
        a.z * b.z +
        a.w * b.w;
}

pub fn cross(a: Tuple, b: Tuple) Tuple {
    return vector(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x);
}
