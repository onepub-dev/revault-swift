// swift-tools-version: 5.9
import PackageDescription

#if os(Linux)
let revaultC: Target = .systemLibrary(name: "RevaultC", path: "CModule")
#else
let revaultC: Target = .binaryTarget(name: "RevaultC", url: "https://github.com/onepub-dev/reVault/releases/download/revault-api-v0.6.2/RevaultC.xcframework.zip", checksum: "1253cf631dffa8cefbf18ff3e933a8f0d38b863627582245d52623572f212d63")
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
