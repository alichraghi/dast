const std = @import("std");
const dast = @import("main.zig");
const testing = std.testing;

test "slice()" {
    const arr = "hello";

    try testing.expectEqualStrings("hell", try dast.slice(u8, arr, 0, 4));
    try testing.expectEqualStrings("hello", try dast.slice(u8, arr, 0, null));
    try testing.expectEqualStrings("o", try dast.slice(u8, arr, 4, 5));
    try testing.expectEqualStrings("", try dast.slice(u8, arr, 5, 5));
    try testing.expectEqualStrings("", try dast.slice(u8, arr, 6, 7));
}

test "includes()" {
    const arr = &[_]u8{ 1, 2, 3 };
    try testing.expect(dast.includes(u8, arr, 2));
    try testing.expect(!dast.includes(u8, arr, 0));
}

test "diff()" {
    const arr1 = &[_]u8{ 1, 2, 3 };
    const arr2 = &[_]u8{ 2, 3, 4 };
    const out = (try dast.diff(u8, testing.allocator, arr1, arr2)).?;
    try testing.expectEqualStrings(out, &[_]u8{ 1, 4 });
    testing.allocator.free(out);
}

test "rm()" {
    {
        var arr = "good".*;

        dast.rm(&arr, 1);
        try testing.expectEqualStrings("god", arr[0..3]);
    }
    {
        var arr = [_]u8{ 0, 1, 2, 0, 3, 0 };
        dast.rm(&arr, 0);
        dast.rm(&arr, 2);
        try testing.expectEqualStrings(&[_]u8{ 1, 2, 3 }, arr[0..3]);
    }
}

test "compact()" {
    const arr = &[_]u8{ 0, 1, 2, 0, 3, 0, 0 };
    const out = try dast.compact(u8, testing.allocator, arr);
    try testing.expectEqualSlices(u8, &[_]u8{ 1, 2, 3 }, out);
    testing.allocator.free(out);
}

test "chunk()" {
    {
        // {}
        const out = try dast.chunk(u8, testing.allocator, "abc", 0);

        try testing.expect(out.len == 0);
    }
    {
        // { { a }, { b }, { c } }
        var out = try dast.chunk(u8, testing.allocator, "abc", 1);

        try testing.expectEqualStrings("a", out[0]);
        try testing.expectEqualStrings("b", out[1]);
        try testing.expectEqualStrings("c", out[2]);
        testing.allocator.free(out);
    }
    {
        // { { a, b }, { c } }
        var out = try dast.chunk(u8, testing.allocator, "abc", 2);

        try testing.expectEqualStrings("ab", out[0]);
        try testing.expectEqualStrings("c", out[1]);
        testing.allocator.free(out);
    }
}

test "filter()" {
    const predFn = struct {
        fn call(el: u8, _: usize) bool {
            return el > 2;
        }
    }.call;
    const arr = &[_]u8{ 1, 2, 3, 4 };
    const out = try dast.filter(u8, std.testing.allocator, arr, predFn);
    try testing.expectEqualSlices(u8, &[_]u8{ 3, 4 }, out);
    testing.allocator.free(out);
}
