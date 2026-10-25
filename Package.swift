// swift-tools-version: 5.9
import PackageDescription

#if os(Linux)
let revaultC: Target = .systemLibrary(name: "RevaultC", path: "CModule")
#else
let revaultC: Target = .binaryTarget(name: "RevaultC", url: "https://github.com/onepub-dev/reVault/releases/download/revault-api-v0.6.0/RevaultC.xcframework.zip", checksum: "0d2e35708328a4c4f5b8aaa34606f256738c095a23410203034d76791471c8f9")
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
            path: "Sources/RevaultAPI",
            linkerSettings: [.linkedLibrary("revault_api", .when(platforms: [.linux]))]
        ),
    ]
)
