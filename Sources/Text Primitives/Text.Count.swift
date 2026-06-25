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
    /// It is the cardinal (quantity) type in the text domain.
    ///
    /// Built on `Tagged<Text, Cardinal>`, inheriting:
    /// - `Sendable`, `Equatable`, `Hashable`, `Comparable`
    /// - Cardinal arithmetic (`+`)
    /// - Construction from ``Text/Offset`` (throws if negative)
    public typealias Count = Tagged<Text, Cardinal>
}
