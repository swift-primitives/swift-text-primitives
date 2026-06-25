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
    /// Namespace for line-oriented text types.
    ///
    /// `Text.Line` groups types that operate at line granularity:
    /// - ``Text/Line/Number``: A 1-based line number.
    /// - ``Text/Line/Column``: A 1-based column offset within a line.
    /// - ``Text/Line/Map``: A sorted array of line-start byte offsets for O(log L) resolution.
    public enum Line {}
}
