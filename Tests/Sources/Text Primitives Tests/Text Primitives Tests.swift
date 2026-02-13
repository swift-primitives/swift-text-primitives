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
        #expect(position.rawValue == 0)
    }

    @Test("init from Int")
    func initFromInt() {
        let position = Text.Position(42)
        #expect(position.rawValue == 42)
    }

    @Test("comparable")
    func comparable() {
        let a = Text.Position(10)
        let b = Text.Position(20)
        #expect(a < b)
        #expect(a <= b)
        #expect(b > a)
        #expect(b >= a)
        #expect(a == Text.Position(10))
    }

    @Test("distance between positions")
    func distance() {
        let a = Text.Position(10)
        let b = Text.Position(25)
        #expect(a.distance(to: b) == 15)
        #expect(b.distance(to: a) == -15)
    }

    @Test("advanced by offset")
    func advanced() {
        let position = Text.Position(10)
        let offset: Text.Offset = 5
        #expect(position.advanced(by: offset) == Text.Position(15))
        #expect(position.advanced(by: Text.Offset(-3)) == Text.Position(7))
    }

    @Test("addition operator with offset")
    func additionWithOffset() {
        let position = Text.Position(10)
        let offset: Text.Offset = 5
        #expect(position + offset == Text.Position(15))
        #expect(position + Text.Offset.zero == position)
    }

    @Test("addition operator with count")
    func additionWithCount() {
        let position = Text.Position(10)
        let count: Text.Count = 5
        #expect(position + count == Text.Position(15))
    }

    @Test("subtraction operator returns typed offset")
    func subtraction() {
        let a = Text.Position(25)
        let b = Text.Position(10)
        #expect(a - b == 15)
    }

    @Test("hashable")
    func hashable() {
        let a = Text.Position(42)
        let b = Text.Position(42)
        #expect(a.hashValue == b.hashValue)

        var set: Set<Text.Position> = [a, b]
        #expect(set.count == 1)
        set.insert(Text.Position(99))
        #expect(set.count == 2)
    }

    @Test("description")
    func description() {
        #expect(Text.Position(42).description == "42")
        #expect(Text.Position.zero.description == "0")
    }
}

// MARK: - Text.Offset

@Suite("Text.Offset")
struct TextOffsetTests {
    @Test("zero offset")
    func zero() {
        #expect(Text.Offset.zero == 0)
    }

    @Test("init from Int")
    func initFromInt() {
        #expect(Text.Offset(42) == 42)
        #expect(Text.Offset(-5) == -5)
    }

    @Test("comparable")
    func comparable() {
        let a: Text.Offset = -1
        let b: Text.Offset = 0
        let c: Text.Offset = 1
        #expect(a < b)
        #expect(b < c)
    }

    @Test("equatable")
    func equatable() {
        let a: Text.Offset = 10
        let b: Text.Offset = 10
        let c: Text.Offset = 11
        #expect(a == b)
        #expect(a != c)
    }

    @Test("hashable")
    func hashable() {
        let a: Text.Offset = 5
        let b: Text.Offset = 5
        var set: Set<Text.Offset> = [a, b]
        #expect(set.count == 1)
    }

    @Test("Int boundary conversion")
    func intConversion() {
        let offset: Text.Offset = 42
        #expect(Int(offset) == 42)
    }

    @Test("description")
    func description() {
        #expect(Text.Offset(15).description == "15")
        #expect(Text.Offset(-3).description == "-3")
    }
}

// MARK: - Text.Count

@Suite("Text.Count")
struct TextCountTests {
    @Test("zero count")
    func zero() {
        #expect(Text.Count.zero == 0)
    }

    @Test("init from Int")
    func initFromInt() {
        #expect(Text.Count(42) == 42)
    }

    @Test("init from offset")
    func initFromOffset() {
        let offset = Text.Offset(15)
        #expect(Text.Count(offset) == 15)
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
    func intConversion() {
        let count: Text.Count = 42
        #expect(Int(count) == 42)
    }

    @Test("description")
    func description() {
        #expect(Text.Count(15).description == "15")
    }
}

// MARK: - Text.Range

@Suite("Text.Range")
struct TextRangeTests {
    @Test("init from start and end")
    func initStartEnd() {
        let range = Text.Range(start: Text.Position(10), end: Text.Position(20))
        #expect(range.start == Text.Position(10))
        #expect(range.end == Text.Position(20))
    }

    @Test("init from start and count")
    func initStartCount() {
        let range = Text.Range(start: Text.Position(10), count: Text.Count(15))
        #expect(range.start == Text.Position(10))
        #expect(range.end == Text.Position(25))
    }

    @Test("count returns Text.Count")
    func count() {
        let range = Text.Range(start: Text.Position(10), end: Text.Position(25))
        #expect(range.count == 15)
    }

    @Test("empty range")
    func emptyRange() {
        let range = Text.Range(start: Text.Position(10), end: Text.Position(10))
        #expect(range.isEmpty)
        #expect(range.count == 0)
    }

    @Test("non-empty range is not empty")
    func nonEmptyRange() {
        let range = Text.Range(start: Text.Position(0), end: Text.Position(1))
        #expect(!range.isEmpty)
    }

    @Test("contains position")
    func contains() {
        let range = Text.Range(start: Text.Position(10), end: Text.Position(20))
        #expect(range.contains(Text.Position(10)))
        #expect(range.contains(Text.Position(15)))
        #expect(range.contains(Text.Position(19)))
        #expect(!range.contains(Text.Position(20)))
        #expect(!range.contains(Text.Position(9)))
        #expect(!range.contains(Text.Position(25)))
    }

    @Test("equatable")
    func equatable() {
        let a = Text.Range(start: Text.Position(10), end: Text.Position(20))
        let b = Text.Range(start: Text.Position(10), end: Text.Position(20))
        let c = Text.Range(start: Text.Position(10), end: Text.Position(21))
        #expect(a == b)
        #expect(a != c)
    }

    @Test("hashable")
    func hashable() {
        let a = Text.Range(start: Text.Position(10), end: Text.Position(20))
        let b = Text.Range(start: Text.Position(10), end: Text.Position(20))
        var set: Set<Text.Range> = [a, b]
        #expect(set.count == 1)
        set.insert(Text.Range(start: Text.Position(0), end: Text.Position(5)))
        #expect(set.count == 2)
    }

    @Test("description")
    func description() {
        let range = Text.Range(start: Text.Position(10), end: Text.Position(20))
        #expect(range.description == "10..<20")
    }

    @Test("zero-length range at zero")
    func zeroLengthAtZero() {
        let range = Text.Range(start: .zero, count: .zero)
        #expect(range.isEmpty)
        #expect(range.start == .zero)
        #expect(range.end == .zero)
    }
}
