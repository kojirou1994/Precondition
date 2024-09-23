// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Precondition",
  products: [
    .library(name: "Precondition", targets: ["Precondition"]),
  ],
  targets: [
    .target(name: "Precondition"),
    .testTarget(
      name: "PreconditionTests",
      dependencies: ["Precondition"]),
  ]
)
