// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PackageUtils",
    products: [
        .plugin(
            name: "CreateArtifactBundle",
            targets: ["CreateArtifactBundle"]
        )
    ],
    dependencies: [],
    targets: [
        .plugin(
            name: "CreateArtifactBundle",
            capability: .command(
                intent: .custom(
                    verb: "create-artifact-bundle",
                    description: "Creates a .zip containing executable products"
                )
            )
        )
    ]
)
