// swift-tools-version: 5.9
import PackageDescription

#if os(Linux)
let revaultC: Target = .systemLibrary(name: "RevaultC", path: "CModule")
#else
let revaultC: Target = .binaryTarget(name: "RevaultC", url: "https://github.com/onepub-dev/reVault/releases/download/revault-api-v0.5.1/RevaultC.xcframework.zip", checksum: "c19f5c0ca55e754f5d3d3ad7b6ffc6763b30864be5e17015d45521bce12ed79d")
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
