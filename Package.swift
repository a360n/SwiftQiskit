// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwiftQiskit",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        // Core library
        .library(
            name: "SwiftQiskit",
            targets: ["SwiftQiskitCore"]
        ),

        // CLI example
        .executable(
            name: "SwiftQiskitExamples",
            targets: ["SwiftQiskitExamples"]
        ),

        // SwiftUI GUI
        .executable(
            name: "SwiftQiskitGUI",
            targets: ["SwiftQiskitGUI"]
        )
    ],
    targets: [
        // =========================
        // Core quantum engine
        // =========================
        .target(
            name: "SwiftQiskitCore",
            path: "Sources/SwiftQiskitCore"
        ),

        // =========================
        // CLI Example (Bell State)
        // =========================
        .executableTarget(
            name: "SwiftQiskitExamples",
            dependencies: ["SwiftQiskitCore"],
            path: "Examples"
        ),

        // =========================
        // Tests
        // =========================
        .testTarget(
            name: "SwiftQiskitCoreTests",
            dependencies: ["SwiftQiskitCore"],
            path: "Tests/SwiftQiskitCoreTests"
        ),

        // =========================
        // SwiftUI GUI App
        // =========================
        .executableTarget(
            name: "SwiftQiskitGUI",
            dependencies: ["SwiftQiskitCore"],
            path: "SwiftQiskitGUI/Sources",
            swiftSettings: [
                .unsafeFlags(["-parse-as-library"])
            ]
        )
    ]
)
