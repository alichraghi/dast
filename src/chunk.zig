const std = @import("std");
const dast = @import("main.zig");
const mem = std.mem;

/// groups an array of elements with the length of `size`.
/// if `arr` can't be split, then chunks the remaining elements.
///
/// ```
/// const out = try dast.chunk(u8, allocator, "abcd", 2); // -> {{a, b}, {c, d}}
/// defer allocator.free(out);
/// ```
pub fn chunk(comptime T: type, allocator: mem.Allocator, arr: []const T, size: usize) ![][]const T {
    if (arr.len == 0 or size == 0) return &[_][]const T{};

    var i: usize = 0;
    var result = std.ArrayList([]const T).init(allocator);

    while (i < arr.len) : (i += size) {
        try result.append(try dast.slice(T, arr, i, i + size));
    }

    return result.toOwnedSlice();
}
