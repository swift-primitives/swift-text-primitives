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

extension Text {
    /// A half-open byte range within UTF-8 encoded text.
    ///
    /// Represents the contiguous byte sequence `[start, end)` where `start`
    /// is inclusive and `end` is exclusive. This follows the universal compiler
    /// convention used by swiftc, Clang, rust-analyzer, swift-syntax, tree-sitter,
    /// and LSP.
    ///
    /// ## Invariant
    ///
    /// `start <= end`. Empty ranges are valid: `start == end`.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let range = Text.Range(start: Text.Position(10), end: Text.Position(25))
    /// range.count    // 15
    /// range.isEmpty  // false
    /// range.contains(Text.Position(15))  // true
    /// ```
    public struct Range: Sendable, Equatable, Hashable {
        /// The inclusive start position (first byte in the range).
        public let start: Text.Position

        /// The exclusive end position (first byte after the range).
        public let end: Text.Position

        /// Creates a half-open range from start and end positions.
        ///
        /// - Parameters:
        ///   - start: The inclusive start position.
        ///   - end: The exclusive end position. Must be >= `start`.
        @inlinable
        public init(start: Text.Position, end: Text.Position) {
            self.start = start
            self.end = end
        }

        /// Creates a range from a start position and byte count.
        ///
        /// - Parameters:
        ///   - start: The inclusive start position.
        ///   - count: The number of bytes in the range.
        @inlinable
        public init(start: Text.Position, count: Text.Count) {
            self.start = start
            self.end = start + count
        }
    }
}

// MARK: - Properties

extension Text.Range {
    /// The number of bytes in this range.
    @inlinable
    public var count: Text.Count {
        Text.Count(start.distance(to: end))
    }

    /// Whether this range contains zero bytes.
    @inlinable
    public var isEmpty: Bool {
        start == end
    }

    /// Whether this range contains the given position.
    ///
    /// A position is contained if `start <= position < end`.
    @inlinable
    public func contains(_ position: Text.Position) -> Bool {
        start <= position && position < end
    }
}

// MARK: - CustomStringConvertible

extension Text.Range: CustomStringConvertible {
    @inlinable
    public var description: Swift.String {
        "\(start.rawValue)..<\(end.rawValue)"
    }
}
