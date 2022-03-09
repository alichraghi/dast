const std = @import("std");
const dast = @import("main.zig");

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
