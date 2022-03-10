const std = @import("std");
const dast = @import("main.zig");
const mem = std.mem;

/// groups an array of elements with the length of `size`.
/// if `arr` can't be split, then chunks the remaining elements.
///
/// ```
/// const out = try dast.chunk(u8, allocator, "abcd", 2); // -> {{a, b}, {c, d}}
/// defer allocator.free(chunked);
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
