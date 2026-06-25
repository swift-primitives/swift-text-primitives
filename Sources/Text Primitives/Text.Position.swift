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
    /// Built on `Tagged<Text, Ordinal>`, inheriting:
    /// - `Sendable`, `Equatable`, `Hashable`, `Comparable`
    /// - `.zero` static property
    /// - Affine arithmetic with ``Text/Offset``
    /// - `retag(_:)` for zero-cost cross-domain conversion
    public typealias Position = Tagged<Text, Ordinal>
}
