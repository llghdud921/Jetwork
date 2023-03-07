// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Jetwork",
    
    /// iOS 15.0부터 사용 가능합니다
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Jetwork",
            targets: ["Jetwork"]),
    ],
    targets: [
        .target(
            name: "Jetwork",
            dependencies: []),
        .testTarget(
            name: "JetworkTests",
            dependencies: ["Jetwork"]),
    ]
)
