// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "alfred-workflow-utils",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "AlfredWorkflowUpdater", targets: ["AlfredWorkflowUpdaterCore"]),
        .library(name: "AlfredWorkflowScriptFilter", targets: ["AlfredWorkflowScriptFilter"]),
        .executable(name: "alfred-workflow-updater", targets: ["AlfredWorkflowUpdaterCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.5.0")),
    ],
    targets: [
        .executableTarget(
            name: "AlfredWorkflowUpdaterCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "AlfredWorkflowUpdaterCore",
            ],
            path: "Sources/AlfredWorkflowUtils/Updater/CLI"
        ),
        .target(
            name: "AlfredWorkflowUpdaterCore",
            dependencies: ["AlfredCore"],
            path: "Sources/AlfredWorkflowUtils/Updater/Core"
        ),
        .target(
            name: "AlfredWorkflowScriptFilter",
            dependencies: [
                "AlfredCore",
            ],
            path: "Sources/AlfredWorkflowUtils/ScriptFilter"
        ),
        .target(
            name: "AlfredCore",
            dependencies: [],
            path: "Sources/AlfredWorkflowUtils/AlfredCore"
        ),
        .testTarget(
            name: "AlfredWorkflowUtilsTests",
            dependencies: [
//                "AlfredWorkflowUpdaterCLI",
//                "AlfredWorkflowUpdaterCore",
                "AlfredWorkflowScriptFilter",
            ],
            path: "Tests/AlfredWorkflowUtilsTests"
//            resources: [.process("Resources")]
        )
    ]
)
