// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwiftQiskit",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SwiftQiskit",
            targets: ["SwiftQiskitCore"]
        )
    ],
    targets: [
        // Core quantum logic (math, statevector, gates, simulator)
        .target(
            name: "SwiftQiskitCore",
            path: "Sources/SwiftQiskitCore"
        ),

        // Unit tests for the core
        .testTarget(
            name: "SwiftQiskitCoreTests",
            dependencies: ["SwiftQiskitCore"],
            path: "Tests/SwiftQiskitCoreTests"
        )
    ]
)
