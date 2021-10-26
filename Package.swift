// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bayes",
    products: [
        .library(
            name: "Bayes",
            targets: ["Bayes"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Bayes",
            dependencies: []),
        .testTarget(
            name: "BayesTests",
            dependencies: ["Bayes"]),
    ]
)
