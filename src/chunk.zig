const std = @import("std");
const dast = @import("main.zig");
const mem = std.mem;

/// groups an array of elements with the length of `size`.
/// if `arr` can't be split, then chunks the remaining elements.
///
/// ```zig
/// var chunked = try dast.chunk(u8, testing.allocator, "abcd", 2); // -> {{a, b}, {c, d}}
/// defer testing.allocator.free(chunked); // don't forgot to free ;)
/// try testing.expectEqualStrings("ab", chunked[0]);
/// try testing.expectEqualStrings("c", chunked[1]);
/// ```
pub fn chunk(comptime T: type, allocator: mem.Allocator, arr: []const T, size: usize) ![][]const T {
    if (arr.len == 0 or size == 0) return &[_][]const T{};

    var index: usize = 0;
    var result = std.ArrayList([]const T).init(allocator);

    while (index < arr.len) : (index += size) {
        try result.append(try dast.slice(T, arr, index, index + size));
    }

    return result.toOwnedSlice();
}
