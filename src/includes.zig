/// check if `el` (element) exist in `arr`
///
/// ```
/// const res = includes(u8, &[_]u8{1, 2, 3}, 2) // -> true
/// ```
pub fn includes(comptime T: type, arr: []const T, el: T) bool {
    for (arr) |item| {
        if (item == el) return true;
    }
    return false;
}
