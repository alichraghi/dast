pub fn rm(arr: anytype, index: usize) void {
    if (index > arr.len - 1) return;
    var i = index;
    while (i < arr.len) : (i += 1) {
        const next_val = if (i == arr.len - 1) 0x0 else arr[i + 1];
        arr[i] = next_val;
    }
}
