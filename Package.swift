// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

//
//  Package.swift
//  rsa-public-key-importer-exporter
//
//  Created by nextincrement on 27/07/2019.
//  Copyright © 2019 nextincrement
//

import PackageDescription

var targets: [PackageDescription.Target] = [
  .target(
    name: "RSAPublicKeyImporter",
    dependencies: ["SimpleASN1Reader"]),
  .target(
    name: "RSAPublicKeyExporter",
    dependencies: ["SimpleASN1Writer"]),
  .target(
    name: "RSAPublicKeyImportExportDemo",
    dependencies: ["RSAPublicKeyImporter", "RSAPublicKeyExporter"]),
  .testTarget(
    name: "RSAPublicKeyImporterTests",
    dependencies: ["RSAPublicKeyImporter"]),
  .testTarget(
    name: "RSAPublicKeyExporterTests",
    dependencies: ["RSAPublicKeyExporter"]),
]

let package = Package(
  name: "rsa-public-key-importer-exporter",
  products: [
    .executable(name: "RSAPublicKeyImportExportDemo", targets: ["RSAPublicKeyImportExportDemo"]),
    .library(
      name: "RSAPublicKeyImporter",
      targets: ["RSAPublicKeyImporter"]),
    .library(
      name: "RSAPublicKeyExporter",
      targets: ["RSAPublicKeyExporter"]),
  ],
  dependencies: [
    .package(url: "https://github.com/nextincrement/simple-asn1-reader-writer.git", from: "0.1.0")
  ],
  targets: targets
)
