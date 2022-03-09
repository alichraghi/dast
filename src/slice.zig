const std = @import("std");
const math = std.math;

const Error = error{InvalidIndex};

pub fn slice(comptime T: type, arr: []const T, start: usize, end: ?usize) Error![]const T {
    if (end) |e| {
        if (start > e) {
            return Error.InvalidIndex;
        }
        return arr[math.min(arr.len, start)..math.min(arr.len, math.max(e, 0))];
    }
    return arr[math.min(arr.len, start)..];
}
