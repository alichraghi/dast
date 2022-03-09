const std = @import("std");
const dast = @import("main.zig");
const mem = std.mem;

pub fn chunk(comptime T: type, allocator: mem.Allocator, arr: []const T, size: usize) ![][]const T {
    if (arr.len == 0 or size == 0) return &[_][]const T{};

    var index: usize = 0;
    var result = std.ArrayList([]const T).init(allocator);

    while (index < arr.len) : (index += size) {
        try result.append(try dast.slice(T, arr, index, index + size));
    }

    return result.toOwnedSlice();
}
