// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GeekAPI",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(name: "GeekAPI", targets: ["GeekAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/yonaskolb/Codability.git", from: "0.2.1"),
    ],
    targets: [
        .target(name: "GeekAPI", dependencies: ["Codability"]),
        .testTarget(name: "GeekAPITests", dependencies: ["Codability", "GeekAPI"]),
    ]
)
