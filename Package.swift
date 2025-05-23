// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdvancedZip",
    platforms: [
        .iOS(.v15),  // iOS 15 and later
        .macOS(.v12),  // macOS Monterey (12) and later
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AdvancedZip",
            targets: ["AdvancedZip"]),
        .library(
            name: "AdvancedZip-Static",
            type: .static,
            targets: ["AdvancedZip"]),
        .library(
            name: "AdvancedZip-Dynamic",
            type: .dynamic,
            targets: ["AdvancedZip"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "LZMA",
            path: "Sources/ObjCAdvancedZip/LZMA.xcframework"
        ),
        .target(
            name: "ObjCAdvancedZip",
            dependencies: ["LZMA"],
            path: "Sources/ObjCAdvancedZip",
            cSettings: [
                .headerSearchPath("include"),
                .define("HAVE_INTTYPES_H"),
                .define("HAVE_PKCRYPT"),
                .define("HAVE_STDINT_H"),
                .define("HAVE_WZAES"),
                .define("HAVE_ZLIB"),
                .define("ZLIB_COMPAT"),
                .define("HAVE_LZMA"),
                .define("LZMA_API_STATIC"),
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("iconv"),
                .linkedFramework("Security"),
            ]
        ),
        .target(
            name: "AdvancedZip",
            dependencies: ["ObjCAdvancedZip"]),
        .testTarget(
            name: "AdvancedZipTests",
            dependencies: ["AdvancedZip"]),
    ]
)
