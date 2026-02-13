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
    /// A signed byte displacement within UTF-8 encoded text.
    ///
    /// `Text.Offset` represents the distance between two ``Text/Position``
    /// values, or an amount by which to advance a position. It is the
    /// displacement type in the affine space where ``Text/Position`` is
    /// the point type.
    ///
    /// This mirrors the relationship in the typed infrastructure where
    /// `Ordinal` (position) and `Affine.Discrete.Vector` (displacement)
    /// are separate types. Positions are points; offsets are vectors.
    ///
    /// ## Design
    ///
    /// - Backed by `Int` (signed) because displacements can be negative.
    /// - `Sendable`, `Equatable`, `Hashable`, `Comparable`.
    public struct Offset: Sendable, Equatable, Hashable, Comparable {
        /// The signed byte displacement.
        public let rawValue: Int

        /// Creates an offset from a byte displacement.
        ///
        /// - Parameter rawValue: The signed byte displacement.
        @inlinable
        public init(_ rawValue: Int) {
            self.rawValue = rawValue
        }

        /// Zero displacement.
        @inlinable
        public static var zero: Text.Offset {
            Text.Offset(0)
        }

        // MARK: - Comparable

        @inlinable
        public static func < (lhs: Text.Offset, rhs: Text.Offset) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}

// MARK: - CustomStringConvertible

extension Text.Offset: CustomStringConvertible {
    @inlinable
    public var description: Swift.String {
        "\(rawValue)"
    }
}

// MARK: - Standard Library Boundary

extension Int {
    /// Converts a text offset to an integer at a domain boundary.
    ///
    /// Use this at boundaries where text-domain values meet non-text APIs
    /// (e.g., computing 1-based column numbers from byte displacements).
    @inlinable
    public init(_ offset: Text.Offset) {
        self = offset.rawValue
    }
}
