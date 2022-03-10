const std = @import("std");
const dast = @import("main.zig");
const mem = std.mem;

/// returns the differences between two array values
///
/// ```
/// const out = try dast.diff(u8, allocator, &[_]u8{1, 2, 3}, &[_]u8{2, 3, 4}); // -> {1, 4}
/// defer allocator.free(out);
/// ```
pub fn diff(comptime T: type, allocator: mem.Allocator, a: []const T, b: []const T) mem.Allocator.Error!?[]T {
    if (a.len == 0 or b.len == 0 or a.ptr == b.ptr) return null;

    var result = std.ArrayList(T).init(allocator);

    for (a) |el| {
        if (!dast.includes(T, b, el)) {
            try result.append(el);
        }
    }

    for (b) |el| {
        if (!dast.includes(T, a, el)) {
            try result.append(el);
        }
    }

    return result.toOwnedSlice();
}
