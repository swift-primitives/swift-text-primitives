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
    @Test("zero is byte offset 0")
    func zero() {
        let position = Text.Position.zero
        #expect(position == 0)
    }

    @Test("literal construction")
    func literalConstruction() {
        let position: Text.Position = 42
        #expect(position == 42)
    }

    @Test("comparable")
    func comparable() {
        let a: Text.Position = 10
        let b: Text.Position = 20
        #expect(a < b)
        #expect(a <= b)
        #expect(b > a)
        #expect(b >= a)
        #expect(a == 10)
    }

    @Test("subtraction returns typed offset")
    func subtraction() throws {
        let a: Text.Position = 25
        let b: Text.Position = 10
        let offset: Text.Offset = try a - b
        #expect(offset == Text.Offset(15))
    }

    @Test("addition with offset")
    func additionWithOffset() throws {
        let position: Text.Position = 10
        let offset = Text.Offset(5)
        #expect(try position + offset == 15)
        #expect(try position + Text.Offset.zero == position)
    }

    @Test("hashable")
    func hashable() {
        let a: Text.Position = 42
        let b: Text.Position = 42
        #expect(a.hashValue == b.hashValue)

        var set: Set<Text.Position> = [a, b]
        #expect(set.count == 1)
        let c: Text.Position = 99
        set.insert(c)
        #expect(set.count == 2)
    }

    @Test("description")
    func description() {
        let pos: Text.Position = 42
        #expect(pos.description == "42")
        #expect(Text.Position.zero.description == "0")
    }
}

// MARK: - Text.Offset

@Suite("Text.Offset")
struct TextOffsetTests {
    @Test("zero offset")
    func zero() {
        #expect(Text.Offset.zero == Text.Offset(0))
    }

    @Test("init from Int")
    func initFromInt() {
        #expect(Text.Offset(42) == Text.Offset(42))
        #expect(Text.Offset(-5) == Text.Offset(-5))
    }

    @Test("comparable")
    func comparable() {
        let a = Text.Offset(-1)
        let b = Text.Offset(0)
        let c = Text.Offset(1)
        #expect(a < b)
        #expect(b < c)
    }

    @Test("equatable")
    func equatable() {
        let a = Text.Offset(10)
        let b = Text.Offset(10)
        let c = Text.Offset(11)
        #expect(a == b)
        #expect(a != c)
    }

    @Test("hashable")
    func hashable() {
        let a = Text.Offset(5)
        let b = Text.Offset(5)
        var set: Set<Text.Offset> = [a, b]
        #expect(set.count == 1)
    }

    @Test("vector access")
    func vectorAccess() {
        let offset = Text.Offset(42)
        #expect(offset.vector.rawValue == 42)
    }

    @Test("description")
    func description() {
        #expect(Text.Offset(15).description == "Vector(15)")
        #expect(Text.Offset(-3).description == "Vector(-3)")
    }
}

// MARK: - Text.Count

@Suite("Text.Count")
struct TextCountTests {
    @Test("literal construction")
    func literalConstruction() {
        let count: Text.Count = 42
        #expect(count == 42)
    }

    @Test("init from offset")
    func initFromOffset() throws {
        let offset = Text.Offset(15)
        let count = try Text.Count(offset)
        #expect(count == 15)
    }

    @Test("comparable")
    func comparable() {
        let a: Text.Count = 5
        let b: Text.Count = 10
        #expect(a < b)
        #expect(b > a)
    }

    @Test("equatable")
    func equatable() {
        let a: Text.Count = 10
        let b: Text.Count = 10
        #expect(a == b)
    }

    @Test("Int boundary conversion")
    func intConversion() throws {
        let count: Text.Count = 42
        #expect(try Int(count) == 42)
    }

    @Test("description")
    func description() {
        let count: Text.Count = 15
        #expect(count.description == "15")
    }
}

// MARK: - Text.Range

@Suite("Text.Range")
struct TextRangeTests {
    @Test("init from start and end")
    func initStartEnd() {
        let range = Text.Range(start: 10, end: 20)
        #expect(range.start == 10)
        #expect(range.end == 20)
    }

    @Test("init from start and count")
    func initStartCount() {
        let range = Text.Range(start: 10, count: 15)
        #expect(range.start == 10)
        #expect(range.end == 25)
    }

    @Test("count returns Text.Count")
    func count() {
        let range = Text.Range(start: 10, end: 25)
        #expect(range.count == 15)
    }

    @Test("empty range")
    func emptyRange() {
        let range = Text.Range(start: 10, end: 10)
        #expect(range.isEmpty)
        #expect(range.count == 0)
    }

    @Test("non-empty range is not empty")
    func nonEmptyRange() {
        let range = Text.Range(start: 0, end: 1)
        #expect(!range.isEmpty)
    }

    @Test("contains position")
    func contains() {
        let range = Text.Range(start: 10, end: 20)
        #expect(range.contains(10))
        #expect(range.contains(15))
        #expect(range.contains(19))
        #expect(!range.contains(20))
        #expect(!range.contains(9))
        #expect(!range.contains(25))
    }

    @Test("equatable")
    func equatable() {
        let a = Text.Range(start: 10, end: 20)
        let b = Text.Range(start: 10, end: 20)
        let c = Text.Range(start: 10, end: 21)
        #expect(a == b)
        #expect(a != c)
    }

    @Test("hashable")
    func hashable() {
        let a = Text.Range(start: 10, end: 20)
        let b = Text.Range(start: 10, end: 20)
        var set: Set<Text.Range> = [a, b]
        #expect(set.count == 1)
        set.insert(Text.Range(start: 0, end: 5))
        #expect(set.count == 2)
    }

    @Test("description")
    func description() {
        let range = Text.Range(start: 10, end: 20)
        #expect(range.description == "10..<20")
    }

    @Test("zero-length range at zero")
    func zeroLengthAtZero() {
        let range = Text.Range(start: .zero, end: .zero)
        #expect(range.isEmpty)
        #expect(range.start == .zero)
        #expect(range.end == .zero)
    }
}

// MARK: - Text.Line.Number

@Suite("Text.Line.Number")
struct TextLineNumberTests {
    @Test("init from UInt")
    func initFromUInt() {
        let number = Text.Line.Number(1)
        #expect(number.rawValue == 1)
    }

    @Test("literal construction")
    func literalConstruction() {
        let number: Text.Line.Number = 42
        #expect(number.rawValue == 42)
    }

    @Test("init from Int — valid")
    func initFromIntValid() throws {
        let value: Int = 5
        let number = try Text.Line.Number(value)
        #expect(number.rawValue == 5)
    }

    @Test("init from Int — zero")
    func initFromIntZero() throws {
        let value: Int = 0
        let number = try Text.Line.Number(value)
        #expect(number.rawValue == 0)
    }

    @Test("init from Int — negative throws")
    func initFromIntNegativeThrows() {
        let value: Int = -1
        #expect(throws: Text.Line.Number.Error.negativeSource(-1)) {
            try Text.Line.Number(value)
        }
    }

    @Test("init exactly — valid")
    func initExactlyValid() {
        let value: Int = 5
        let number = Text.Line.Number(exactly: value)
        #expect(number?.rawValue == 5)
    }

    @Test("init exactly — negative returns nil")
    func initExactlyNegative() {
        let value: Int = -1
        #expect(Text.Line.Number(exactly: value) == nil)
    }

    @Test("comparable")
    func comparable() {
        let a: Text.Line.Number = 1
        let b: Text.Line.Number = 10
        #expect(a < b)
        #expect(b > a)
        #expect(a <= a)
    }

    @Test("equatable")
    func equatable() {
        let a: Text.Line.Number = 5
        let b: Text.Line.Number = 5
        let c: Text.Line.Number = 6
        #expect(a == b)
        #expect(a != c)
    }

    @Test("hashable")
    func hashable() {
        let a: Text.Line.Number = 5
        let b: Text.Line.Number = 5
        var set: Set<Text.Line.Number> = [a, b]
        #expect(set.count == 1)
        set.insert(10)
        #expect(set.count == 2)
    }

    @Test("description")
    func description() {
        let number: Text.Line.Number = 42
        #expect(number.description == "42")
    }

}

// MARK: - Text.Location

@Suite("Text.Location")
struct TextLocationTests {
    @Test("init from line and column")
    func initLineColumn() {
        let location = Text.Location(
            line: 5,
            column: Text.Line.Column(__unchecked: (), Cardinal(10))
        )
        #expect(location.line == 5)
        #expect(location.column == 10)
    }

    @Test("description is line:column")
    func description() {
        let location = Text.Location(
            line: 42,
            column: Text.Line.Column(__unchecked: (), Cardinal(17))
        )
        #expect(location.description == "42:17")
    }

    @Test("comparable — different lines")
    func comparableDifferentLines() {
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

    @Test("comparable — same line, different columns")
    func comparableSameLineDifferentColumns() {
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

    @Test("comparable — equal")
    func comparableEqual() {
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

    @Test("hashable")
    func hashable() {
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

    @Test("empty content — one line")
    func emptyContent() {
        let map = lineMap(for: "")
        #expect(map.lineCount == 1)
    }

    @Test("single line — no newline")
    func singleLineNoNewline() {
        let map = lineMap(for: "hello")
        #expect(map.lineCount == 1)
        #expect(map.line(containing: 0) == 1)
        #expect(map.line(containing: 4) == 1)
    }

    @Test("LF line endings")
    func lfLineEndings() {
        // "a\nb\nc"
        let map = lineMap(for: "a\nb\nc")
        #expect(map.lineCount == 3)
        #expect(map.line(containing: 0) == 1) // 'a'
        #expect(map.line(containing: 1) == 1) // '\n'
        #expect(map.line(containing: 2) == 2) // 'b'
        #expect(map.line(containing: 4) == 3) // 'c'
    }

    @Test("CR line endings")
    func crLineEndings() {
        // "a\rb\rc"
        let map = lineMap(for: "a\rb\rc")
        #expect(map.lineCount == 3)
        #expect(map.line(containing: 0) == 1)
        #expect(map.line(containing: 2) == 2)
        #expect(map.line(containing: 4) == 3)
    }

    @Test("CRLF line endings")
    func crlfLineEndings() {
        // "a\r\nb\r\nc"
        let map = lineMap(for: "a\r\nb\r\nc")
        #expect(map.lineCount == 3)
        #expect(map.line(containing: 0) == 1) // 'a'
        #expect(map.line(containing: 3) == 2) // 'b'
        #expect(map.line(containing: 6) == 3) // 'c'
    }

    @Test("trailing newline adds empty line")
    func trailingNewline() {
        let map = lineMap(for: "a\n")
        #expect(map.lineCount == 2)
    }

    @Test("column computation — 1-based")
    func columnComputation() {
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

    @Test("location composition")
    func locationComposition() {
        // "abc\ndef"
        let map = lineMap(for: "abc\ndef")
        let location = map.location(for: 6) // 'f'
        #expect(location.line == 2)
        #expect(location.column == 3)
        #expect(location.description == "2:3")
    }

    @Test("offset for line — valid")
    func offsetForLineValid() {
        // "abc\ndef"
        let map = lineMap(for: "abc\ndef")
        #expect(map.offset(forLine: 1) == 0)
        #expect(map.offset(forLine: 2) == 4)
    }

    @Test("offset for line — out of range")
    func offsetForLineOutOfRange() {
        let map = lineMap(for: "abc")
        #expect(map.offset(forLine: 0) == nil)
        #expect(map.offset(forLine: 2) == nil)
    }

    @Test("mixed line endings")
    func mixedLineEndings() {
        // "a\nb\rc\r\nd"
        let map = lineMap(for: "a\nb\rc\r\nd")
        #expect(map.lineCount == 4)
        #expect(map.line(containing: 0) == 1) // 'a'
        #expect(map.line(containing: 2) == 2) // 'b'
        #expect(map.line(containing: 4) == 3) // 'c'
        #expect(map.line(containing: 7) == 4) // 'd'
    }
}
