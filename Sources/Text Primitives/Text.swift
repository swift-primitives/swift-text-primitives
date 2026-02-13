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

/// Namespace for text abstractions.
///
/// `Text` provides position and range types for working with UTF-8
/// encoded text. All positions are byte offsets into UTF-8 sequences.
///
/// ## Types
///
/// - ``Text/Position``: A byte offset into text.
/// - ``Text/Offset``: A signed byte displacement between positions.
/// - ``Text/Count``: A non-negative byte quantity.
/// - ``Text/Range``: A half-open byte range within text.
///
/// ## Design
///
/// Text-primitives is encoding-agnostic at the type level but assumes
/// UTF-8 semantics. All byte offsets are UTF-8 byte offsets. Higher-level
/// encoding conversions (e.g., UTF-16 for LSP) belong at integration
/// boundaries, not in primitives.
public enum Text {}
