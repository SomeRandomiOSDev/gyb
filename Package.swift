// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "gyb",

    products: [
        .executable(name: "gyb", targets: ["gyb"])
    ],

    targets: [
        .target(name: "gyb")
    ]
)
