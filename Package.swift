// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Katafract",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "KatafractStyle", targets: ["KatafractStyle"]),
    ],
    targets: [
        .target(
            name: "KatafractStyle",
            path: "Sources/KatafractStyle"
        ),
        .testTarget(
            name: "KatafractStyleTests",
            dependencies: ["KatafractStyle"],
            path: "Tests/KatafractStyleTests"
        ),
    ]
)
