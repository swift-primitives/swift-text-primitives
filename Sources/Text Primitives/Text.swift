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

/// Namespace and phantom tag for text abstractions.
///
/// `Text` provides position and range types for working with UTF-8
/// encoded text. All positions are byte offsets into UTF-8 sequences.
///
/// ## Types
///
/// - ``Text/Position``: A byte offset into text (`Tagged<Text, Ordinal>`).
/// - ``Text/Offset``: A signed byte displacement (`Tagged<Text, Affine.Discrete.Vector>`).
/// - ``Text/Count``: A non-negative byte quantity (`Tagged<Text, Cardinal>`).
/// - ``Text/Range``: A half-open byte range within text.
///
/// ## Design
///
/// Text-primitives builds on the affine infrastructure: positions are ordinals
/// (points), offsets are vectors (displacements), counts are cardinals (quantities).
/// All three are phantom-tagged with `Text` for compile-time domain safety.
///
/// Text-primitives is encoding-agnostic at the type level but assumes
/// UTF-8 semantics. All byte offsets are UTF-8 byte offsets. Higher-level
/// encoding conversions (e.g., UTF-16 for LSP) belong at integration
/// boundaries, not in primitives.
public enum Text {}
