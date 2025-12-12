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
        ),
        .executable(
            name: "SwiftQiskitExamples",
            targets: ["SwiftQiskitExamples"]
        )
    ],
    targets: [
        .target(
            name: "SwiftQiskitCore",
            path: "Sources/SwiftQiskitCore"
        ),
        .executableTarget(
            name: "SwiftQiskitExamples",
            dependencies: ["SwiftQiskitCore"],
            path: "Examples"
        )
    ]
)
