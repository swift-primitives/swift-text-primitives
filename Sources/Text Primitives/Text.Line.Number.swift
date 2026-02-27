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

extension Text.Line {
    /// A 1-based line number within text.
    ///
    /// Line numbers are 1-based: the first line of any text is line 1.
    /// This matches the universal convention used by compilers, editors,
    /// and diagnostic tools (GCC, Clang, swiftc, LSP, `#line`).
    ///
    /// Backed by `UInt` to make non-negativity representational.
    /// The value 0 is permitted at the type level but has no semantic
    /// meaning as a line number — callers are responsible for ensuring
    /// 1-based semantics where required.
    public struct Number: Sendable, Hashable, Comparable, Codable {
        /// The underlying unsigned integer value.
        public let rawValue: UInt

        /// Creates a line number from an unsigned integer.
        ///
        /// - Parameter value: The line number value (typically 1-based).
        @inlinable
        public init(_ value: UInt) {
            self.rawValue = value
        }
    }
}

// MARK: - Int Conversions

extension Text.Line.Number {
    /// Errors that can occur during line number construction.
    public enum Error: Swift.Error, Hashable, Sendable {
        /// The source integer was negative.
        ///
        /// - Parameter value: The negative value that was provided.
        case negativeSource(Int)
    }

    /// Creates a line number from a signed integer, returning `nil` if negative.
    ///
    /// - Parameter value: The signed integer value.
    /// - Returns: A line number if `value >= 0`, otherwise `nil`.
    @inlinable
    public init?(exactly value: Int) {
        guard value >= 0 else { return nil }
        self.init(UInt(value))
    }

    /// Creates a line number from a signed integer, throwing if negative.
    ///
    /// - Parameter value: The signed integer value.
    /// - Throws: `Error.negativeSource` if `value < 0`.
    @inlinable
    public init(_ value: Int) throws(Error) {
        guard value >= 0 else {
            throw .negativeSource(value)
        }
        self.init(UInt(value))
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension Text.Line.Number: ExpressibleByIntegerLiteral {
    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}

// MARK: - Comparable

extension Text.Line.Number {
    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

// MARK: - CustomStringConvertible

extension Text.Line.Number: CustomStringConvertible {
    @inlinable
    public var description: Swift.String {
        "\(rawValue)"
    }
}
