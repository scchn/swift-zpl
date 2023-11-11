// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-zpl",
    products: [
        .library(name: "ZPLBuilder", targets: ["ZPLBuilder"]),
    ],
    targets: [
        .target(name: "ZPLBuilder"),
        .testTarget(name: "ZPLBuilderTests", dependencies: ["ZPLBuilder"]),
    ]
)
