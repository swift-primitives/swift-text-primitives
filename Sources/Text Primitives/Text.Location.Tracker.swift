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

extension Text.Location {
    /// Incremental line/column tracker with O(1) position resolution.
    ///
    /// Maintains running line state as a cursor advances through text.
    /// Callers report newlines via ``newline(at:)``, then query
    /// ``location(at:)`` for the current line:column at any position.
    ///
    /// Complements ``Text/Line/Map`` (eager O(n) build, O(log L) query)
    /// with a streaming alternative (incremental, O(1) query). Use Map
    /// for batch post-hoc diagnostics; use Tracker for streaming lexers
    /// that need per-token position.
    ///
    /// Modeled after `compnerd/xylem`'s `LocationTracker`.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// var tracker = Text.Location.Tracker()
    ///
    /// // Cursor advances through source bytes. When a newline is found:
    /// tracker.newline(at: newlinePosition)
    ///
    /// // Query line:column at any position on the current line:
    /// let loc = tracker.location(at: cursor)  // O(1)
    /// ```
    ///
    /// ## CRLF
    ///
    /// For `\r\n` sequences, call ``newline(at:)`` once for the `\r`.
    /// Do not call it again for the `\n` — the pair is one logical newline.
    public struct Tracker: Sendable, Equatable, Hashable {
        /// The current 1-based line number.
        public var line: Text.Line.Number

        /// The byte position of the first byte on the current line.
        public var lineStart: Text.Position

        /// Creates a tracker at the beginning of text: line 1, column 1.
        @inlinable
        public init() {
            self.line = 1
            self.lineStart = .zero
        }
    }
}

// MARK: - Recording

extension Text.Location.Tracker {
    /// Records a newline at the given cursor position.
    ///
    /// Increments the line number and sets the start of the next line to
    /// the byte after `position`. For CRLF, call this once for the `\r`;
    /// skip the `\n`.
    ///
    /// - Parameter position: The byte position of the newline character.
    @inlinable
    public mutating func newline(at position: Text.Position) {
        line = Text.Line.Number(line.rawValue + 1)
        lineStart = position + .one
    }
}

// MARK: - Query

extension Text.Location.Tracker {
    /// Computes the ``Text/Location`` for the given cursor position.
    ///
    /// The column is the 1-based UTF-8 byte offset from the start of
    /// the current line: `column = (cursor - lineStart) + 1`.
    ///
    /// - Parameter cursor: The byte position to resolve.
    /// - Returns: The line:column location.
    /// - Precondition: `cursor >= lineStart` (cursor must be on or past
    ///   the current line).
    @inlinable
    public func location(at cursor: Text.Position) -> Text.Location {
        let offset: Text.Offset = try! cursor - lineStart
        let bytes: Text.Count = offset.magnitude
        let column: Text.Line.Column = bytes + .one
        return Text.Location(line: line, column: column)
    }
}
