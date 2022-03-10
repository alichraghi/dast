const math = @import("std").math;

const Error = error{InvalidIndex};

/// a safer wrapper for slice picking syntax (`arr[1..3]`), that return errors instead of runtime panics such as *`index out of bounds`*.
///
/// **NOTE:** if `start` or `end` be larger than array length, so will be replaced with `arr.len`
///
/// ```
/// const arr = "hello";
/// try testing.expectEqualStrings("hell", try dast.slice(u8, arr, 0, 4));
/// ```
pub fn slice(comptime T: type, arr: []const T, start: usize, end: ?usize) Error![]const T {
    if (end) |e| {
        if (start > e) {
            return Error.InvalidIndex;
        }
        return arr[math.min(arr.len, start)..math.min(arr.len, e)];
    }
    return arr[math.min(arr.len, start)..];
}
