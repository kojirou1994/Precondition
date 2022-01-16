// swift-tools-version:5.2

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
