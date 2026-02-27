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
    /// A 1-based column offset within a line, measured in UTF-8 bytes.
    ///
    /// Columns represent the byte offset from the start of a line.
    /// Column 1 is the first byte of the line, matching compiler conventions.
    ///
    /// This is a typealias for ``Text/Count`` (i.e., `Tagged<Text, Cardinal>`),
    /// reusing the existing cardinal type for byte quantities.
    public typealias Column = Text.Count
}
