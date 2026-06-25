# Text Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Text types for Swift — phantom-tagged byte positions, ranges, and line/column locations over UTF-8 text, with zero platform dependencies.

---

## Quick Start

`Text` is a phantom namespace over UTF-8 byte offsets. Positions, offsets, and counts are `Tagged` aliases (`Text.Position`, `Text.Offset`, `Text.Count`), so a byte offset into one buffer cannot be mixed with an unrelated quantity — the domain is checked at compile time, and arithmetic is the affine algebra of points, vectors, and magnitudes.

```swift
import Text_Primitives

// Positions are byte offsets; arithmetic is typed and affine.
let start: Text.Position = 10
let end: Text.Position = 25
let span: Text.Offset = try end - start   // Text.Offset(15)

// A half-open byte range [start, end).
let range = Text.Range(start: 10, count: 15)
range.count            // Text.Count == 15
range.contains(12)     // true
```

Resolve a byte offset to a human-readable `line:column` with a line map. `Text.Line.Map` scans UTF-8 bytes once (recognizing LF, CR, and CRLF) and answers in O(log L):

```swift
let map = Text.Line.Map(scanning: "ab\ncd\n".utf8.map(Byte.init))
map.line(containing: 3)   // Text.Line.Number == 2
map.location(for: 3)      // Text.Location — "2:1"
```

For streaming lexers that need per-token positions without an eager scan, `Text.Location.Tracker` maintains running line state with O(1) queries: report each newline via `newline(at:)`, then read `location(at:)` for the current cursor.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-text-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Text Primitives", package: "swift-text-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Two library products. Foundation-free.

| Product | Target | Purpose |
|---------|--------|---------|
| `Text Primitives` | `Sources/Text Primitives/` | The `Text` namespace: `Text.Position` / `Text.Offset` / `Text.Count` (phantom-tagged affine types), `Text.Range`, `Text.Location` (line:column), and `Text.Line` (`Number`, `Column`, `Map`, `Location.Tracker`). |
| `Text Primitives Test Support` | `Tests/Support/` | Re-exports the main target for test consumers. |

Built on `swift-affine-primitives` (ordinals / vectors / cardinals), `swift-carrier-primitives` (`Tagged`), `swift-byte-primitives` (`Byte`), and `swift-ownership-primitives` (borrow view).

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |
| Swift Embedded | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
