//
//  XCTestManifests.swift
//  rsa-public-key-importer-exporter
//
//  Created by nextincrement on 27/07/2019.
//  Copyright © 2019 nextincrement
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(RSAPublicKeyExporterTests.allTests),
  ]
}
#endif
