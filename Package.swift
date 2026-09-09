// swift-tools-version: 5.9
import PackageDescription

#if os(Linux)
let revaultC: Target = .systemLibrary(name: "RevaultC", path: "CModule")
#else
let revaultC: Target = .binaryTarget(name: "RevaultC", url: "https://github.com/onepub-dev/reVault/releases/download/revault-api-v0.3.15/RevaultC.xcframework.zip", checksum: "e79ad4fcddeef178789644b5282e00b8c6ccbb111e82eb9224ca8d5da53c256f")
#endif

let package = Package(
    name: "RevaultAPI",
    products: [.library(name: "RevaultAPI", targets: ["RevaultAPI"])],
    dependencies: [
        .package(url: "https://github.com/google/flatbuffers.git", exact: "25.2.10"),
    ],
    targets: [
        revaultC,
        .target(
            name: "RevaultAPI",
            dependencies: ["RevaultC", .product(name: "FlatBuffers", package: "flatbuffers")],
            path: "Sources/RevaultAPI"
        ),
    ]
)
