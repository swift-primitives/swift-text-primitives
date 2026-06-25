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

// Text.Line.Number conforms to Carrier.`Protocol` with `Underlying = UInt`
// per the Q1 recipe (Copyable & Escapable) in the Carrier conformance recipes.
//
// The conformance is one declaration plus zero additional implementation —
// `Text.Line.Number`'s existing `var underlying: UInt` and `init(_ value: UInt)`
// already satisfy the protocol's `var underlying { borrowing get }` and
// `init(_ underlying: consuming Underlying)` requirements.
//
// What the conformance unlocks:
//
//   1. Cross-type generic dispatch — consumers can write generic
//      functions over `some Carrier.\`Protocol\`<UInt>` that accept
//      both bare `UInt` (via Carrier Primitives Standard Library
//      Integration) and `Text.Line.Number` uniformly.
//
//   2. The throwing init with validation closure inherited from
//      `extension Carrier.\`Protocol\` where Self: ~Copyable & ~Escapable` —
//      consumers can write
//      `try Text.Line.Number(value, validate: { ... })` for free.
//
//   3. The `Domain` associatedtype defaults to `Never` per the Carrier
//      protocol declaration — bare line numbers are unscoped.
//
// Per the L1-additive scope of this dispatch, no bespoke Line arithmetic
// is added here: typed arithmetic over line numbers (Line ± offset,
// distance) is a Wave 2 evaluation against the swift-source-primitives /
// swift-parsers / swift-linter consumer cascade, not an L1 concern.

public import Carrier_Primitives

extension Text.Line.Number: Carrier.`Protocol` {
    /// `Text.Line.Number` carries a `UInt` line index.
    ///
    /// The `Underlying` is the bare `UInt` (not `Self`) because the
    /// type's storage is `underlying: UInt` — the wrapper adds 1-based
    /// line-number semantics on top of the raw integer, and the
    /// protocol's `Underlying` names the carried value.
    ///
    /// The `Domain` associatedtype defaults to `Never` per the
    /// `Carrier.\`Protocol\`` declaration.
    public typealias Underlying = UInt

    // The protocol's `var underlying: UInt { borrowing get }` requirement
    // is satisfied by the existing stored property `public let underlying: UInt`
    // declared on `Text.Line.Number`. The protocol's `init(_:)` requirement
    // is satisfied by the existing `public init(_ value: UInt)` initializer.
}
