// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "CMyLibrary",
            targets: ["CMyLibrary"]),
    ],
    targets: [
        .target(
            name: "CMyLibrary",
            publicHeadersPath: "include"
        ),
        .testTarget(
            name: "CMyLibraryTests",
            dependencies: ["CMyLibrary"]),
    ]
)