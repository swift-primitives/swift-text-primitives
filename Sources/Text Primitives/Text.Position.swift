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
    /// A byte offset into UTF-8 encoded text.
    ///
    /// `Text.Position` is the fundamental unit for tracking locations in text.
    /// It represents a zero-based byte offset from the start of a text buffer.
    ///
    /// All major compiler implementations (swiftc, Clang, rust-analyzer, Roslyn,
    /// swift-syntax) use byte offsets as their primary position representation,
    /// with line/column derived lazily via line maps.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let start = Text.Position.zero
    /// let end = Text.Position(42)
    /// let range = Text.Range(start: start, end: end)
    /// ```
    ///
    /// ## Design
    ///
    /// - Backed by `Int` for consistency with Swift Standard Library conventions
    ///   (Array.count, String.utf8.count, etc. are all `Int`).
    /// - `Sendable`, `Equatable`, `Hashable`, `Comparable` — suitable for use
    ///   as dictionary keys, sorted collection elements, and cross-isolation transfer.
    public struct Position: Sendable, Equatable, Hashable, Comparable {
        /// The zero-based byte offset.
        public let rawValue: Int

        /// Creates a position from a byte offset.
        ///
        /// - Parameter rawValue: The zero-based byte offset. Must be non-negative.
        @inlinable
        public init(_ rawValue: Int) {
            self.rawValue = rawValue
        }

        /// The start of text (byte offset zero).
        @inlinable
        public static var zero: Text.Position {
            Text.Position(0)
        }

        // MARK: - Comparable

        @inlinable
        public static func < (lhs: Text.Position, rhs: Text.Position) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}

// MARK: - Arithmetic

extension Text.Position {
    /// Returns the byte displacement from this position to `other`.
    ///
    /// - Parameter other: The target position.
    /// - Returns: A positive offset if `other` is after `self`, negative if before.
    @inlinable
    public func distance(to other: Text.Position) -> Text.Offset {
        Text.Offset(other.rawValue - self.rawValue)
    }

    /// Returns a new position advanced by the given offset.
    ///
    /// - Parameter offset: The byte displacement to apply.
    /// - Returns: The new position.
    @inlinable
    public func advanced(by offset: Text.Offset) -> Text.Position {
        Text.Position(rawValue + offset.rawValue)
    }
}

// MARK: - Operators

extension Text.Position {
    /// Advances a position by a typed byte offset.
    @inlinable
    public static func + (lhs: Text.Position, rhs: Text.Offset) -> Text.Position {
        lhs.advanced(by: rhs)
    }

    /// Advances a position by a typed byte count.
    @inlinable
    public static func + (lhs: Text.Position, rhs: Text.Count) -> Text.Position {
        Text.Position(lhs.rawValue + rhs.rawValue)
    }

    /// Returns the typed byte displacement between two positions.
    @inlinable
    public static func - (lhs: Text.Position, rhs: Text.Position) -> Text.Offset {
        rhs.distance(to: lhs)
    }
}

// MARK: - CustomStringConvertible

extension Text.Position: CustomStringConvertible {
    @inlinable
    public var description: Swift.String {
        "\(rawValue)"
    }
}
