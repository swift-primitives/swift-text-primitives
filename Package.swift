// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-text-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Text Primitives",
            targets: ["Text Primitives"]
        ),
        .library(
            name: "Text Primitives Test Support",
            targets: ["Text Primitives Test Support"]
        ),
    ],
    dependencies: [
        // Text processing operates on strings
        .package(path: "../swift-string-primitives"),
    ],
    targets: [
        .target(
            name: "Text Primitives",
            dependencies: [
                .product(name: "String Primitives", package: "swift-string-primitives"),
            ]
        ),
        .target(
            name: "Text Primitives Test Support",
            dependencies: [
                "Text Primitives",
            ],
            path: "Tests/Support"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableExperimentalFeature("Lifetimes"),
        .strictMemorySafety()
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
