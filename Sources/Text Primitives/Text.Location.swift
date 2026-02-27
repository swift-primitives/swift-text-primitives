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
    /// A human-readable position in text expressed as a line and column.
    ///
    /// `Text.Location` is the product type `Text.Line.Number × Text.Line.Column`.
    /// It represents a resolved, display-oriented position in text, in contrast
    /// to ``Text/Position`` which is a raw byte offset.
    ///
    /// Both line and column are 1-based, matching the universal convention
    /// used by compilers (GCC, Clang, swiftc), editors, and diagnostic tools.
    ///
    /// ## Design
    ///
    /// `Text.Location` is the shared substructure factored out of higher-level
    /// location types like `Source.Location`. Any domain that needs a line:column
    /// pair composes `Text.Location` rather than reinventing the fields.
    public struct Location: Sendable, Hashable {
        /// The 1-based line number.
        public let line: Text.Line.Number

        /// The 1-based column offset within the line, measured in UTF-8 bytes.
        public let column: Text.Line.Column

        /// Creates a location from a line number and column.
        ///
        /// - Parameters:
        ///   - line: The 1-based line number.
        ///   - column: The 1-based column offset.
        @inlinable
        public init(line: Text.Line.Number, column: Text.Line.Column) {
            self.line = line
            self.column = column
        }
    }
}

// MARK: - Codable

extension Text.Location: Codable {
    @usableFromInline
    internal enum CodingKeys: Swift.String, CodingKey {
        case line
        case column
    }

    @inlinable
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let lineValue = try container.decode(UInt.self, forKey: .line)
        let columnValue = try container.decode(UInt.self, forKey: .column)
        self.line = Text.Line.Number(lineValue)
        self.column = Text.Line.Column(__unchecked: (), Cardinal(columnValue))
    }

    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(line.rawValue, forKey: .line)
        try container.encode(column.rawValue.rawValue, forKey: .column)
    }
}

// MARK: - Comparable

extension Text.Location: Comparable {
    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.line != rhs.line { return lhs.line < rhs.line }
        return lhs.column < rhs.column
    }
}

// MARK: - CustomStringConvertible

extension Text.Location: CustomStringConvertible {
    @inlinable
    public var description: Swift.String {
        "\(line):\(column)"
    }
}
