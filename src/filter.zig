const std = @import("std");
const dast = @import("main.zig");
const mem = std.mem;

pub fn filter(comptime T: type, allocator: mem.Allocator, arr: []const T, predicate: fn (T, usize) bool) mem.Allocator.Error![]T {
    var index: usize = 0;
    var result = std.ArrayList(T).init(allocator);

    while (index < arr.len) : (index += 1) {
        if (predicate(arr[index], index)) {
            try result.append(arr[index]);
        }
    }

    return result.toOwnedSlice();
}
