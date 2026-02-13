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
    /// A non-negative byte quantity within UTF-8 encoded text.
    ///
    /// `Text.Count` represents sizes, lengths, and counts of bytes.
    /// It is the cardinal (quantity) type in the text domain, mirroring
    /// how `Cardinal` serves as the base quantity type in the typed
    /// infrastructure.
    ///
    /// ## Design
    ///
    /// - Backed by `Int` (non-negative by convention) for consistency
    ///   with Swift Standard Library conventions where counts are `Int`.
    /// - `Sendable`, `Equatable`, `Hashable`, `Comparable`.
    public struct Count: Sendable, Equatable, Hashable, Comparable {
        /// The non-negative byte count.
        public let rawValue: Int

        /// Creates a count from a non-negative integer.
        ///
        /// - Parameter rawValue: The byte count. Must be non-negative.
        @inlinable
        public init(_ rawValue: Int) {
            self.rawValue = rawValue
        }

        /// Zero bytes.
        @inlinable
        public static var zero: Text.Count {
            Text.Count(0)
        }

        // MARK: - Comparable

        @inlinable
        public static func < (lhs: Text.Count, rhs: Text.Count) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}

// MARK: - CustomStringConvertible

extension Text.Count: CustomStringConvertible {
    @inlinable
    public var description: Swift.String {
        "\(rawValue)"
    }
}

// MARK: - Conversion

extension Text.Count {
    /// Creates a count from a text offset.
    ///
    /// Use this when a displacement is known to be non-negative
    /// (e.g., the distance from range start to end).
    @inlinable
    public init(_ offset: Text.Offset) {
        self = Text.Count(offset.rawValue)
    }
}

// MARK: - Standard Library Boundary

extension Int {
    /// Converts a text count to an integer at a domain boundary.
    @inlinable
    public init(_ count: Text.Count) {
        self = count.rawValue
    }
}
