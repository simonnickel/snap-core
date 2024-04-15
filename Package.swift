// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "snap-core",
	platforms: [
		.iOS(.v17), .macOS(.v14)
	],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "snap-core",
            targets: ["snap-core"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "snap-core",
			swiftSettings: [
				.enableExperimentalFeature("StrictConcurrency")
			]
		),
        .testTarget(
            name: "snap-coreTests",
            dependencies: ["snap-core"]
		),
    ]
)
