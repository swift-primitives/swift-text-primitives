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
