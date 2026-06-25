# Audit: swift-text-primitives

## Code Surface — 2026-04-16

### Scope

- **Target**: swift-text-primitives (focus: new Text.Location.Tracker)
- **Skill**: code-surface — [API-NAME-001], [API-NAME-002], [API-IMPL-005], [API-IMPL-006], [API-IMPL-008]
- **Files**: 1 new source file (Text.Location.Tracker.swift)

### Findings

| # | Severity | Rule | Location | Finding | Status |
|---|----------|------|----------|---------|--------|
| — | — | — | — | No violations found | — |

### Summary

0 findings. `Text.Location.Tracker` follows Nest.Name: Tracker within Location within Text. File naming matches nested path. Type body contains only stored properties and canonical init. Methods in extensions: `newline(at:)` and `location(at:)` — both single-concept with parameter labels.

---

## Implementation — 2026-04-16

### Scope

- **Target**: swift-text-primitives (focus: new Text.Location.Tracker)
- **Skill**: implementation — [IMPL-002], [IMPL-006], [IMPL-010], [IMPL-INTENT], [IMPL-064]
- **Files**: 1 new source file

### Findings

| # | Severity | Rule | Location | Finding | Status |
|---|----------|------|----------|---------|--------|
| 1 | LOW | [IMPL-002] | Text.Location.Tracker.swift:72 | `Text.Line.Number(line.rawValue + 1)` — raw arithmetic on `.rawValue`. Necessary: `Text.Line.Number` is a plain struct without `Cardinal.Protocol` or `Ordinal.Protocol` conformance, so no typed successor/addition infrastructure exists. | DEFERRED — infrastructure gap on `Text.Line.Number` (no typed increment) |
| 2 | LOW | [IMPL-INTENT] | Text.Location.Tracker.swift:88 | `try! cursor - lineStart` — force-try on subtraction that is safe by construction (cursor >= lineStart). No non-throwing alternative for ordinal subtraction when the result is known non-negative. | DEFERRED — principled: ordinal subtraction IS partial; `try!` documents the contract |

### Summary

2 findings: 0 critical, 0 high, 0 medium, 2 low (both deferred).

Tracker is `Sendable, Equatable, Hashable` (value type with two stored properties). Typed state: `line: Text.Line.Number`, `lineStart: Text.Position`. Column computation matches `Text.Line.Map.column(for:)` formula. Intermediate types explicitly annotated (`let offset: Text.Offset`, `let bytes: Text.Count`, `let column: Text.Line.Column`) to prevent `Cardinal.+` shadowing `Cardinal.Protocol.+` in operator resolution.

---

## Legacy — From: swift-institute/Research/audits/implementation-naming-2026-03-20/swift-small-packages-batch.md (2026-03-20)

**Implementation + naming audit**: CLEAN (0 findings).
