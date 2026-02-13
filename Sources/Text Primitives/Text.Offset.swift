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
    /// vector type in the affine space where ``Text/Position`` is
    /// the point type.
    ///
    /// Built on `Tagged<Text, Affine.Discrete.Vector>`, inheriting:
    /// - `Sendable`, `Equatable`, `Hashable`, `Comparable`
    /// - `.zero` static property
    /// - Vector arithmetic (`+`, `-`, unary `-`)
    /// - `.magnitude` → ``Text/Count``
    public typealias Offset = Tagged<Text, Affine.Discrete.Vector>
}
