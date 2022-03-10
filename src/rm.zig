/// removes an element at `index` from `arr` and then splice the right side elements
/// the remaining items will be initialized to zero (`0x0`)
///
/// ```
/// var arr = "good".*;
/// dast.rm(&arr, 1); // -> {g, o, d, 0x0}
/// ```
pub fn rm(arr: anytype, index: usize) void {
    if (index > arr.len - 1) return;
    var i = index;
    while (i < arr.len) : (i += 1) {
        const next_val = if (i == arr.len - 1) 0x0 else arr[i + 1];
        arr[i] = next_val;
    }
}
