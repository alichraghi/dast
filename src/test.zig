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

test "rm()" {
    var arr = "good".*;

    dast.rm(&arr, 1);
    try testing.expectEqualStrings("god", arr[0..3]);
}

test "compactFixed()" {
    var arr = [_]u8{ 4, 3, 0, 1, 0 };
    const out = try dast.compactFixed(u8, &arr);
    try testing.expectEqualStrings(&[_]u8{ 4, 3, 1 }, out);
}

test "chunk()" {
    {
        // {}
        const chunked = try dast.chunk(u8, testing.allocator, "abc", 0);

        try testing.expect(chunked.len == 0);
    }
    {
        // { { a }, { b }, { c } }
        var chunked = try dast.chunk(u8, testing.allocator, "abc", 1);

        try testing.expectEqualStrings("a", chunked[0]);
        try testing.expectEqualStrings("b", chunked[1]);
        try testing.expectEqualStrings("c", chunked[2]);
        testing.allocator.free(chunked);
    }
    {
        // { { a, b }, { c } }
        var chunked = try dast.chunk(u8, testing.allocator, "abc", 2);

        try testing.expectEqualStrings("ab", chunked[0]);
        try testing.expectEqualStrings("c", chunked[1]);
        testing.allocator.free(chunked);
    }
}
