const std = @import("std");
const dast = @import("main.zig");

/// removes all zero (`0x0`) values from a fixed array buffer (`arr`) and returns an slice since actual values
///
/// ```zig
/// var arr = [_]usize{ 1, 0, 2, 3, 0 };
/// const out = try compactFixed(usize, &arr); // -> {1, 2, 3}
/// try testing.expectEqualStrings(&[_]usize{ 1, 2, 3 }, out);
/// ```
pub fn compactFixed(comptime T: type, arr: []T) ![]const T {
    var slice_end = arr.len;
    for (arr) |el, i| {
        if (el == 0x0) {
            dast.rm(arr, i);
            slice_end -= 1;
        }
    }
    return try dast.slice(T, arr, 0, slice_end + 1);
}
