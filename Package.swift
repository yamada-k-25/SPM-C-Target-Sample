// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MyPackage",
  products: [
    .library(
      name: "CMyLibrary",
      type: .static,
      targets: ["CMyLibrary"])
  ],
  // dependencies: [
  //     .package(
  //         url: "https://github.com/apple/swift-mmio.git",
  //         branch: "swift-embedded-examples"
  //     )
  // ],
  targets: [
    .target(
      name: "CMyLibrary",
      // dependencies: [
      //     .product(name: "MMIO", package: "swift-mmio"),
      // ],
      publicHeadersPath: "include",
      swiftSettings: [
        .enableExperimentalFeature("Embedded"),
        .unsafeFlags(["-Xfrontend", "-function-sections"]),
      ]
    ),
    .target(name: "Support"),
    .testTarget(
      name: "CMyLibraryTests",
      dependencies: ["CMyLibrary"]),
  ]
)
