// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "snap-core",
	platforms: [
		.iOS(.v17), .macOS(.v15)
	],
    products: [
        .library(
            name: "SnapCore",
            targets: ["SnapCore"]),
    ],
	dependencies: [
		.package(url: "https://github.com/simonnickel/snap-foundation.git", branch: "main"),
	],
    targets: [
        .target(
            name: "SnapCore",
			dependencies: [
				.product(name: "SnapFoundation", package: "snap-foundation"),
			]
		),
        .testTarget(
            name: "SnapCoreTests",
            dependencies: ["SnapCore"]
		),
    ],
)
