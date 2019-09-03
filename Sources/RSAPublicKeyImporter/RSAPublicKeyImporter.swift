//
//  RSAPublicKeyImporter.swift
//  rsa-public-key-importer-exporter
//
//  Created by nextincrement on 27/07/2019.
//  Copyright © 2019 nextincrement
//

import Foundation
import SimpleASN1Reader

public struct RSAPublicKeyImporter: RSAPublicKeyImporting {

  // ASN.1 identifier bytes
  private let sequenceIdentifier: UInt8 = 0x30

  // ASN.1 AlgorithmIdentfier for RSA encryption: OID 1 2 840 113549 1 1 1 and NULL
  private let algorithmIdentifierForRSAEncryption: [UInt8] = [0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86,
    0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00]

  public init() {}

  public func fromSubjectPublicKeyInfo(_ subjectPublicKeyInfo: Data) throws -> Data {
    let reader = SimpleASN1Reader([UInt8](subjectPublicKeyInfo))

    // Skip bytes up to the content bytes of the ASN.1 SEQUENCE
    try reader.unwrap(expectedIdentifier: sequenceIdentifier)

    // Skip ASN.1 AlgorithmIdentifier bytes
    try reader.skip(algorithmIdentifierForRSAEncryption)

    // Read contents of the ASN.1 BIT STRING
    let unwrappedKey = try reader.readContentsOfBitString()

    return Data(unwrappedKey)
  }
}
