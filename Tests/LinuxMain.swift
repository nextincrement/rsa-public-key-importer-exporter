//
//  LinuxMain.swift
//  rsa-public-key-importer-exporter
//
//  Created by nextincrement on 27/07/2019.
//  Copyright © 2019 nextincrement
//

import XCTest
import RSAPublicKeyImporterTests
import RSAPublicKeyExporterTests

var tests = [XCTestCaseEntry]()
tests += RSAPublicKeyImporterTests.allTests()
tests += RSAPublicKeyExporterTests.allTests()

XCTMain(tests)
