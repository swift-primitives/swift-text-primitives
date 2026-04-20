// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-text-primitives open source project
//
// Copyright (c) 2025 Coen ten Thije Boonkkamp and the swift-text-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Testing
import Text_Primitives_Test_Support

// MARK: - Text.Position

@Suite("Text.Position")
struct TextPositionTests {
    @Test
    func `zero is byte offset 0`() {
        let position = Text.Position.zero
        #expect(position == 0)
    }

    @Test
    func `literal construction`() {
        let position: Text.Position = 42
        #expect(position == 42)
    }

    @Test
    func `comparable`() {
        let a: Text.Position = 10
        let b: Text.Position = 20
        #expect(a < b)
        #expect(a <= b)
        #expect(b > a)
        #expect(b >= a)
        #expect(a == 10)
    }

    @Test
    func `subtraction returns typed offset`() throws {
        let a: Text.Position = 25
        let b: Text.Position = 10
        let offset: Text.Offset = try a - b
        #expect(offset == Text.Offset(15))
    }

    @Test
    func `addition with offset`() throws {
        let position: Text.Position = 10
        let offset = Text.Offset(5)
        #expect(try position + offset == 15)
        #expect(try position + Text.Offset.zero == position)
    }

    @Test
    func `hashable`() {
        let a: Text.Position = 42
        let b: Text.Position = 42
        #expect(a.hashValue == b.hashValue)

        var set: Set<Text.Position> = [a, b]
        #expect(set.count == 1)
        let c: Text.Position = 99
        set.insert(c)
        #expect(set.count == 2)
    }

    @Test
    func `description`() {
        let pos: Text.Position = 42
        #expect(pos.description == "42")
        #expect(Text.Position.zero.description == "0")
    }
}

// MARK: - Text.Offset

@Suite("Text.Offset")
struct TextOffsetTests {
    @Test
    func `zero offset`() {
        #expect(Text.Offset.zero == Text.Offset(0))
    }

    @Test
    func `init from Int`() {
        #expect(Text.Offset(42) == Text.Offset(42))
        #expect(Text.Offset(-5) == Text.Offset(-5))
    }

    @Test
    func `comparable`() {
        let a = Text.Offset(-1)
        let b = Text.Offset(0)
        let c = Text.Offset(1)
        #expect(a < b)
        #expect(b < c)
    }

    @Test
    func `equatable`() {
        let a = Text.Offset(10)
        let b = Text.Offset(10)
        let c = Text.Offset(11)
        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `hashable`() {
        let a = Text.Offset(5)
        let b = Text.Offset(5)
        var set: Set<Text.Offset> = [a, b]
        #expect(set.count == 1)
    }

    @Test
    func `vector access`() {
        let offset = Text.Offset(42)
        #expect(offset.vector.rawValue == 42)
    }

    @Test
    func `description`() {
        #expect(Text.Offset(15).description == "Vector(15)")
        #expect(Text.Offset(-3).description == "Vector(-3)")
    }
}

// MARK: - Text.Count

@Suite("Text.Count")
struct TextCountTests {
    @Test
    func `literal construction`() {
        let count: Text.Count = 42
        #expect(count == 42)
    }

    @Test
    func `init from offset`() throws {
        let offset = Text.Offset(15)
        let count = try Text.Count(offset)
        #expect(count == 15)
    }

    @Test
    func `comparable`() {
        let a: Text.Count = 5
        let b: Text.Count = 10
        #expect(a < b)
        #expect(b > a)
    }

    @Test
    func `equatable`() {
        let a: Text.Count = 10
        let b: Text.Count = 10
        #expect(a == b)
    }

    @Test
    func `Int boundary conversion`() throws {
        let count: Text.Count = 42
        #expect(try Int(count) == 42)
    }

    @Test
    func `description`() {
        let count: Text.Count = 15
        #expect(count.description == "15")
    }
}

// MARK: - Text.Range

@Suite("Text.Range")
struct TextRangeTests {
    @Test
    func `init from start and end`() {
        let range = Text.Range(start: 10, end: 20)
        #expect(range.start == 10)
        #expect(range.end == 20)
    }

    @Test
    func `init from start and count`() {
        let range = Text.Range(start: 10, count: 15)
        #expect(range.start == 10)
        #expect(range.end == 25)
    }

    @Test
    func `count returns Text.Count`() {
        let range = Text.Range(start: 10, end: 25)
        #expect(range.count == 15)
    }

    @Test
    func `empty range`() {
        let range = Text.Range(start: 10, end: 10)
        #expect(range.isEmpty)
        #expect(range.count == 0)
    }

    @Test
    func `non-empty range is not empty`() {
        let range = Text.Range(start: 0, end: 1)
        #expect(!range.isEmpty)
    }

    @Test
    func `contains position`() {
        let range = Text.Range(start: 10, end: 20)
        #expect(range.contains(10))
        #expect(range.contains(15))
        #expect(range.contains(19))
        #expect(!range.contains(20))
        #expect(!range.contains(9))
        #expect(!range.contains(25))
    }

    @Test
    func `equatable`() {
        let a = Text.Range(start: 10, end: 20)
        let b = Text.Range(start: 10, end: 20)
        let c = Text.Range(start: 10, end: 21)
        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `hashable`() {
        let a = Text.Range(start: 10, end: 20)
        let b = Text.Range(start: 10, end: 20)
        var set: Set<Text.Range> = [a, b]
        #expect(set.count == 1)
        set.insert(Text.Range(start: 0, end: 5))
        #expect(set.count == 2)
    }

    @Test
    func `description`() {
        let range = Text.Range(start: 10, end: 20)
        #expect(range.description == "10..<20")
    }

    @Test
    func `zero-length range at zero`() {
        let range = Text.Range(start: .zero, end: .zero)
        #expect(range.isEmpty)
        #expect(range.start == .zero)
        #expect(range.end == .zero)
    }
}

// MARK: - Text.Line.Number

@Suite("Text.Line.Number")
struct TextLineNumberTests {
    @Test
    func `init from UInt`() {
        let number = Text.Line.Number(1)
        #expect(number.rawValue == 1)
    }

    @Test
    func `literal construction`() {
        let number: Text.Line.Number = 42
        #expect(number.rawValue == 42)
    }

    @Test
    func `init from Int — valid`() throws {
        let value: Int = 5
        let number = try Text.Line.Number(value)
        #expect(number.rawValue == 5)
    }

    @Test
    func `init from Int — zero`() throws {
        let value: Int = 0
        let number = try Text.Line.Number(value)
        #expect(number.rawValue == 0)
    }

    @Test
    func `init from Int — negative throws`() {
        let value: Int = -1
        #expect(throws: Text.Line.Number.Error.negativeSource(-1)) {
            try Text.Line.Number(value)
        }
    }

    @Test
    func `init exactly — valid`() {
        let value: Int = 5
        let number = Text.Line.Number(exactly: value)
        #expect(number?.rawValue == 5)
    }

    @Test
    func `init exactly — negative returns nil`() {
        let value: Int = -1
        #expect(Text.Line.Number(exactly: value) == nil)
    }

    @Test
    func `comparable`() {
        let a: Text.Line.Number = 1
        let b: Text.Line.Number = 10
        #expect(a < b)
        #expect(b > a)
        #expect(a <= a)
    }

    @Test
    func `equatable`() {
        let a: Text.Line.Number = 5
        let b: Text.Line.Number = 5
        let c: Text.Line.Number = 6
        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `hashable`() {
        let a: Text.Line.Number = 5
        let b: Text.Line.Number = 5
        var set: Set<Text.Line.Number> = [a, b]
        #expect(set.count == 1)
        set.insert(10)
        #expect(set.count == 2)
    }

    @Test
    func `description`() {
        let number: Text.Line.Number = 42
        #expect(number.description == "42")
    }

}

// MARK: - Text.Location

@Suite("Text.Location")
struct TextLocationTests {
    @Test
    func `init from line and column`() {
        let location = Text.Location(
            line: 5,
            column: Text.Line.Column(__unchecked: (), Cardinal(10))
        )
        #expect(location.line == 5)
        #expect(location.column == 10)
    }

    @Test
    func `description is line:column`() {
        let location = Text.Location(
            line: 42,
            column: Text.Line.Column(__unchecked: (), Cardinal(17))
        )
        #expect(location.description == "42:17")
    }

    @Test
    func `comparable — different lines`() {
        let a = Text.Location(
            line: 1,
            column: Text.Line.Column(__unchecked: (), Cardinal(99))
        )
        let b = Text.Location(
            line: 2,
            column: Text.Line.Column(__unchecked: (), Cardinal(1))
        )
        #expect(a < b)
    }

    @Test
    func `comparable — same line, different columns`() {
        let a = Text.Location(
            line: 5,
            column: Text.Line.Column(__unchecked: (), Cardinal(1))
        )
        let b = Text.Location(
            line: 5,
            column: Text.Line.Column(__unchecked: (), Cardinal(10))
        )
        #expect(a < b)
    }

    @Test
    func `comparable — equal`() {
        let a = Text.Location(
            line: 5,
            column: Text.Line.Column(__unchecked: (), Cardinal(10))
        )
        let b = Text.Location(
            line: 5,
            column: Text.Line.Column(__unchecked: (), Cardinal(10))
        )
        #expect(a == b)
        #expect(!(a < b))
    }

    @Test
    func `hashable`() {
        let a = Text.Location(
            line: 1,
            column: Text.Line.Column(__unchecked: (), Cardinal(1))
        )
        let b = Text.Location(
            line: 1,
            column: Text.Line.Column(__unchecked: (), Cardinal(1))
        )
        let set: Set<Text.Location> = [a, b]
        #expect(set.count == 1)
    }

}

// MARK: - Text.Line.Map

@Suite("Text.Line.Map")
struct TextLineMapTests {
    /// Helper: scan a string into a line map.
    private func lineMap(for string: Swift.String) -> Text.Line.Map {
        Text.Line.Map(scanning: Array(string.utf8))
    }

    @Test
    func `empty content — one line`() {
        let map = lineMap(for: "")
        #expect(map.lineCount == 1)
    }

    @Test
    func `single line — no newline`() {
        let map = lineMap(for: "hello")
        #expect(map.lineCount == 1)
        #expect(map.line(containing: 0) == 1)
        #expect(map.line(containing: 4) == 1)
    }

    @Test
    func `LF line endings`() {
        // "a\nb\nc"
        let map = lineMap(for: "a\nb\nc")
        #expect(map.lineCount == 3)
        #expect(map.line(containing: 0) == 1) // 'a'
        #expect(map.line(containing: 1) == 1) // '\n'
        #expect(map.line(containing: 2) == 2) // 'b'
        #expect(map.line(containing: 4) == 3) // 'c'
    }

    @Test
    func `CR line endings`() {
        // "a\rb\rc"
        let map = lineMap(for: "a\rb\rc")
        #expect(map.lineCount == 3)
        #expect(map.line(containing: 0) == 1)
        #expect(map.line(containing: 2) == 2)
        #expect(map.line(containing: 4) == 3)
    }

    @Test
    func `CRLF line endings`() {
        // "a\r\nb\r\nc"
        let map = lineMap(for: "a\r\nb\r\nc")
        #expect(map.lineCount == 3)
        #expect(map.line(containing: 0) == 1) // 'a'
        #expect(map.line(containing: 3) == 2) // 'b'
        #expect(map.line(containing: 6) == 3) // 'c'
    }

    @Test
    func `trailing newline adds empty line`() {
        let map = lineMap(for: "a\n")
        #expect(map.lineCount == 2)
    }

    @Test
    func `column computation — 1-based`() {
        // "abc\ndef"
        let map = lineMap(for: "abc\ndef")
        // 'a' at offset 0 → line 1, column 1
        #expect(map.column(for: 0) == 1)
        // 'c' at offset 2 → line 1, column 3
        #expect(map.column(for: 2) == 3)
        // 'd' at offset 4 → line 2, column 1
        #expect(map.column(for: 4) == 1)
        // 'f' at offset 6 → line 2, column 3
        #expect(map.column(for: 6) == 3)
    }

    @Test
    func `location composition`() {
        // "abc\ndef"
        let map = lineMap(for: "abc\ndef")
        let location = map.location(for: 6) // 'f'
        #expect(location.line == 2)
        #expect(location.column == 3)
        #expect(location.description == "2:3")
    }

    @Test
    func `offset for line — valid`() {
        // "abc\ndef"
        let map = lineMap(for: "abc\ndef")
        #expect(map.offset(forLine: 1) == 0)
        #expect(map.offset(forLine: 2) == 4)
    }

    @Test
    func `offset for line — out of range`() {
        let map = lineMap(for: "abc")
        #expect(map.offset(forLine: 0) == nil)
        #expect(map.offset(forLine: 2) == nil)
    }

    @Test
    func `mixed line endings`() {
        // "a\nb\rc\r\nd"
        let map = lineMap(for: "a\nb\rc\r\nd")
        #expect(map.lineCount == 4)
        #expect(map.line(containing: 0) == 1) // 'a'
        #expect(map.line(containing: 2) == 2) // 'b'
        #expect(map.line(containing: 4) == 3) // 'c'
        #expect(map.line(containing: 7) == 4) // 'd'
    }
}
