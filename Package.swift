// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Bayes",
    products: [
            .library(name: "Bayes", targets: ["Bayes"]),
        ],
    targets: [
            .target(
                name: "Bayes",
                dependencies: []),
            .testTarget(
                name: "BayesTests",
                dependencies: ["Bayes"]),
        ]
    )
