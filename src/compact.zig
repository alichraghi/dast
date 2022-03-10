const std = @import("std");
const mem = std.mem;

/// creates an array without zero (`0x0`) values  
///
/// ```
/// const arr = &[_]usize{ 1, 0, 2, 3, 0 };
/// const out = try compact(usize, allocator, arr); // -> {1, 2, 3}
/// defer allocator.free(out);
/// ```
pub fn compact(comptime T: type, allocator: mem.Allocator, arr: []const T) ![]T {
    var result = std.ArrayList(T).init(allocator);
    for (arr) |el| {
        if (el != 0x0) {
            try result.append(el);
        }
    }
    return result.toOwnedSlice();
}
