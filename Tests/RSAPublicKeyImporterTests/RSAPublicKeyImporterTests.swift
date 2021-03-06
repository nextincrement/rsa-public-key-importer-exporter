//
//  RSAPublicKeyImporterTests.swift
//  rsa-public-key-importer-exporter
//
//  Created by nextincrement on 27/07/2019.
//  Copyright © 2019 nextincrement
//

import XCTest
import SimpleASN1Reader
import RSAPublicKeyImporter

/// Note that reader has not been injected and mocked and will thus in fact be tested twice
class RSAPublicKeyImporterTests: XCTestCase {

  // Encoding of an RSA public key, represented with the SubjectPublicKeyInfo type
  private let subjectPublicKeyInfo: [UInt8] = [0x30, 0x81, 0x9f, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86,
    0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x81, 0x8d, 0x00, 0x30, 0x81, 0x89,
    0x02, 0x81, 0x81, 0x00, 0xa7, 0x2a, 0xaf, 0x8e, 0xa3, 0xda, 0xa8, 0x37, 0xaa, 0xb6, 0x2b, 0x30,
    0x92, 0xa4, 0x0d, 0xd3, 0xd2, 0x8c, 0x85, 0xd9, 0x8a, 0xbe, 0x1b, 0xf6, 0xe5, 0xe6, 0x0e, 0xac,
    0x19, 0xbb, 0x88, 0x5c, 0x49, 0x5d, 0xd3, 0x5f, 0x78, 0x15, 0xc8, 0x3a, 0x36, 0x74, 0xe5, 0xc8,
    0x99, 0xd2, 0x6e, 0xa7, 0x73, 0x76, 0xda, 0x40, 0x35, 0x4c, 0xd2, 0xb9, 0x26, 0x07, 0xc4, 0x3c,
    0xc2, 0x9c, 0x6f, 0x3f, 0x76, 0x02, 0x97, 0x8b, 0xdf, 0x6c, 0xb1, 0xac, 0xf3, 0x7e, 0xc8, 0x48,
    0x43, 0xa1, 0x3b, 0x67, 0x9e, 0xb1, 0x1e, 0xe6, 0x62, 0x61, 0x28, 0x2a, 0xfd, 0x20, 0x3e, 0x19,
    0x94, 0xfe, 0x15, 0x74, 0xdf, 0x51, 0x66, 0x46, 0x76, 0xe1, 0xa7, 0x1e, 0x86, 0xad, 0x99, 0x79,
    0x10, 0xfa, 0x6f, 0x63, 0x2b, 0x86, 0xbe, 0x9a, 0x06, 0x5d, 0x13, 0xa7, 0x40, 0x7f, 0x3c, 0xbc,
    0x84, 0x35, 0x62, 0x01, 0x02, 0x03, 0x01, 0x00, 0x01]

  // Erroneous (!) encoding of an RSA public key. Position 15: 0x01 -> 0x07
  private let subjectPublicKeyInfo_invalidObjectIdentifier: [UInt8] = [0x30, 0x81, 0x9f, 0x30, 0x0d,
    0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x07, 0x05, 0x00, 0x03, 0x81, 0x8d,
    0x00, 0x30, 0x81, 0x89, 0x02, 0x81, 0x81, 0x00, 0xa7, 0x2a, 0xaf, 0x8e, 0xa3, 0xda, 0xa8, 0x37,
    0xaa, 0xb6, 0x2b, 0x30, 0x92, 0xa4, 0x0d, 0xd3, 0xd2, 0x8c, 0x85, 0xd9, 0x8a, 0xbe, 0x1b, 0xf6,
    0xe5, 0xe6, 0x0e, 0xac, 0x19, 0xbb, 0x88, 0x5c, 0x49, 0x5d, 0xd3, 0x5f, 0x78, 0x15, 0xc8, 0x3a,
    0x36, 0x74, 0xe5, 0xc8, 0x99, 0xd2, 0x6e, 0xa7, 0x73, 0x76, 0xda, 0x40, 0x35, 0x4c, 0xd2, 0xb9,
    0x26, 0x07, 0xc4, 0x3c, 0xc2, 0x9c, 0x6f, 0x3f, 0x76, 0x02, 0x97, 0x8b, 0xdf, 0x6c, 0xb1, 0xac,
    0xf3, 0x7e, 0xc8, 0x48, 0x43, 0xa1, 0x3b, 0x67, 0x9e, 0xb1, 0x1e, 0xe6, 0x62, 0x61, 0x28, 0x2a,
    0xfd, 0x20, 0x3e, 0x19, 0x94, 0xfe, 0x15, 0x74, 0xdf, 0x51, 0x66, 0x46, 0x76, 0xe1, 0xa7, 0x1e,
    0x86, 0xad, 0x99, 0x79, 0x10, 0xfa, 0x6f, 0x63, 0x2b, 0x86, 0xbe, 0x9a, 0x06, 0x5d, 0x13, 0xa7,
    0x40, 0x7f, 0x3c, 0xbc, 0x84, 0x35, 0x62, 0x01, 0x02, 0x03, 0x01, 0x00, 0x01]

  // Encoding of the same (valid) key as above, represented with the RSAPublicKey type
  private let rsaPublicKey: [UInt8] = [0x30, 0x81, 0x89, 0x02, 0x81, 0x81, 0x00, 0xa7, 0x2a, 0xaf,
    0x8e, 0xa3, 0xda, 0xa8, 0x37, 0xaa, 0xb6, 0x2b, 0x30, 0x92, 0xa4, 0x0d, 0xd3, 0xd2, 0x8c, 0x85,
    0xd9, 0x8a, 0xbe, 0x1b, 0xf6, 0xe5, 0xe6, 0x0e, 0xac, 0x19, 0xbb, 0x88, 0x5c, 0x49, 0x5d, 0xd3,
    0x5f, 0x78, 0x15, 0xc8, 0x3a, 0x36, 0x74, 0xe5, 0xc8, 0x99, 0xd2, 0x6e, 0xa7, 0x73, 0x76, 0xda,
    0x40, 0x35, 0x4c, 0xd2, 0xb9, 0x26, 0x07, 0xc4, 0x3c, 0xc2, 0x9c, 0x6f, 0x3f, 0x76, 0x02, 0x97,
    0x8b, 0xdf, 0x6c, 0xb1, 0xac, 0xf3, 0x7e, 0xc8, 0x48, 0x43, 0xa1, 0x3b, 0x67, 0x9e, 0xb1, 0x1e,
    0xe6, 0x62, 0x61, 0x28, 0x2a, 0xfd, 0x20, 0x3e, 0x19, 0x94, 0xfe, 0x15, 0x74, 0xdf, 0x51, 0x66,
    0x46, 0x76, 0xe1, 0xa7, 0x1e, 0x86, 0xad, 0x99, 0x79, 0x10, 0xfa, 0x6f, 0x63, 0x2b, 0x86, 0xbe,
    0x9a, 0x06, 0x5d, 0x13, 0xa7, 0x40, 0x7f, 0x3c, 0xbc, 0x84, 0x35, 0x62, 0x01, 0x02, 0x03, 0x01,
    0x00, 0x01]

  func testFromSubjectPublicKeyInfo() throws {

    // Prepare test
    let subjectPublicKeyInfoData = toData(subjectPublicKeyInfo)

    print("\nDER encoding represented with the SubjectPublicKeyinfo type:")
    printAsHexString(subjectPublicKeyInfoData)

    // Call function under test
    let rsaPublicKeyData = try RSAPublicKeyImporter().fromSubjectPublicKeyInfo(
      subjectPublicKeyInfoData
    )

    print("\nDER encoding represented with the RSAPublicKey type:")
    printAsHexString(rsaPublicKeyData)

    // Check result
    let expectedRSAPublicKeyData = toData(rsaPublicKey)

    print("\nExpected DER encoding represented with the RSAPublicKey type:")
    printAsHexString(expectedRSAPublicKeyData)

    XCTAssertEqual(expectedRSAPublicKeyData, rsaPublicKeyData)
  }

  func testErrorIfObjectIdentifierHasUnexpectedValue() {

    // Prepare test
    let dataWithInvalidObjectIdentifier = toData(subjectPublicKeyInfo_invalidObjectIdentifier)
    var thrownError: Error?

    // Call function under test
    XCTAssertThrowsError(
      try RSAPublicKeyImporter().fromSubjectPublicKeyInfo(dataWithInvalidObjectIdentifier)
    ) { thrownError = $0 }

    // Check thrown error
    XCTAssertTrue(thrownError is ASN1ReadError, "Unexpected error type: \(type(of: thrownError))")

    let expectedError = ASN1ReadError.invalidBytes(
      expectedBytes: [0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00],
      actualBytes: [0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x07, 0x05, 0x00
      ],
      atPosition: 3,
      ofEncoding: subjectPublicKeyInfo_invalidObjectIdentifier
    )
    XCTAssertEqual(thrownError as? ASN1ReadError, expectedError)
  }

  // MARK: - Convenience functions and test config

  private func toData(_ bytes: [UInt8]) -> Data {
    return Data(bytes: bytes, count: bytes.count)
  }

  private func printAsHexString(_ data: Data) {
    print(data.map{ String(format: "%02x ", $0) }.joined())
  }

  static var allTests = [
    ("testFromSubjectPublicKeyInfo", testFromSubjectPublicKeyInfo),
    ("testErrorIfObjectIdentifierHasUnexpectedValue",
      testErrorIfObjectIdentifierHasUnexpectedValue),
  ]
}
