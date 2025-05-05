// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MyPackage",
  platforms: [.macOS(.v14)],
  products: [
    .library(
      name: "CMyLibrary",
      type: .static,
      targets: ["CMyLibrary"])
  ],
  targets: [
    .target(
      name: "CMyLibrary",
      dependencies: [
        "Support"
      ],
      swiftSettings: [
        .enableExperimentalFeature("Embedded"),
        .unsafeFlags(["-Xfrontend", "-function-sections"]),
      ]
    ),
    .target(
      name: "Support",
      publicHeadersPath: "include"
    ),
  ]
)
