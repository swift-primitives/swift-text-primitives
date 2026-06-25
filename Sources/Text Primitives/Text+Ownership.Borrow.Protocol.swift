// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-text-primitives open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-text-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

public import Byte_Primitives
public import Ownership_Borrow_Primitives

// MARK: - Text: Ownership.Borrow.`Protocol`

/// Conforms `Text` to `Ownership.Borrow.\`Protocol\`` with `Borrowed`
/// resolved to `Swift.Span<Byte>`.
///
/// Text's storage IS bytes — `Text` is the UTF-8-byte-encoded phantom
/// domain (per ``Text`` docs: "All byte offsets are UTF-8 byte offsets").
/// The domain identity is carried at the phantom-tag layer
/// (`Tagged<Text, Ordinal>` for positions, `Tagged<Text, Cardinal>` for
/// counts), while the underlying borrow-view shape is bare `Swift.Span<Byte>`
/// — a `~Copyable, ~Escapable` view over a contiguous byte region.
///
/// This is a principled domain-identity statement, not a wrapper bridge:
/// the canonical single-generic borrowed-bytes cursor `Cursor<Text>`
/// becomes valid as a borrowed UTF-8 byte-stream cursor whose phantom
/// domain is `Text`, with the same byte-level performance and lifetime
/// guarantees as `Cursor<Byte>`.
///
/// Per `swift-institute/Research/cursor-shape-a-vs-three-worlds.md` v1.2.0
/// (the single-generic refinement of the v1.1.0 DECISION) and
/// `swift-institute/Research/ownership-borrow-protocol-unification.md`
/// v1.0.0 — `Text` is a Case-B-shaped conformer where the `Borrowed`
/// type is the stdlib `Swift.Span<Byte>` (after the W3 `.Borrowed` prune)
/// rather than a locally-declared nominal. The typealias satisfies the
/// protocol's associated-type requirement; it is not a unification bridge
/// per [API-NAME-004], nor a namespace-adoption typealias per
/// [API-NAME-004a] — it is a protocol-witness binding chosen by structural
/// correctness. `Cursor<Text>.storage` is therefore `Swift.Span<Byte>`,
/// identical to `Cursor<Byte>` and `Cursor<Binary>`.
extension Text: Ownership.Borrow.`Protocol` {
    /// A borrow view over the underlying UTF-8 bytes as a `Swift.Span<Byte>`.
    public typealias Borrowed = Swift.Span<Byte>
}
