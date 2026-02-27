// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "UtilitiesKit",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(name: "UtilitiesKit", targets: ["UtilitiesKit"]),
        .library(name: "DeviceKit", targets: ["DeviceKit"]),
        .library(name: "DeviceKitUI", targets: ["DeviceKitUI"]),
    ],
    targets: [
        // MARK: - Sources

        .target(
            name: "UtilitiesKit",
            path: "Sources/UtilitiesKit"
        ),
        .target(
            name: "DeviceKit",
            dependencies: ["UtilitiesKit"],
            path: "Sources/DeviceKit"
        ),
        .target(
            name: "DeviceKitUI",
            dependencies: ["DeviceKit"],
            path: "Sources/DeviceKitUI"
        ),

        // MARK: - Tests

        .testTarget(
            name: "UtilitiesKitTests",
            dependencies: ["UtilitiesKit"],
            path: "Tests/UtilitiesKitTests"
        ),
        .testTarget(
            name: "DeviceKitTests",
            dependencies: ["DeviceKit"],
            path: "Tests/DeviceKitTests"
        ),
    ],
    swiftLanguageModes: [.v6]
)
