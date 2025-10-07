// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VoteKit",
    platforms: [
         .iOS(.v13)
    ],
    products: [
        .library(
            name: "VoteKit",
            targets: ["VoteKit"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ControlKit/ControlKitBase.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "VoteKit",
            dependencies: ["ControlKitBase"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "VoteKitTests",
            dependencies: ["VoteKit"]
        ),
    ]
)
