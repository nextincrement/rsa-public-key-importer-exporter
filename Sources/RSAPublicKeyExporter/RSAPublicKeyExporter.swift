//
//  RSAPublicKeyExporter.swift
//  rsa-public-key-importer-exporter
//
//  Created by nextincrement on 27/07/2019.
//  Copyright © 2019 nextincrement
//

import Foundation
import SimpleASN1Writer

public struct RSAPublicKeyExporter: RSAPublicKeyExporting {

  // ASN.1 identifier byte
  public let sequenceIdentifier: UInt8 = 0x30

  // ASN.1 AlgorithmIdentfier for RSA encryption containing OID 1 2 840 113549 1 1 1; NULL
  private let algorithmIdentifierForRSAEncryption: [UInt8] = [0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86,
    0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00]

  public init() {}

  public func toSubjectPublicKeyInfo(_ rsaPublicKey: Data) -> Data {
    let writer = SimpleASN1Writer()

    // Insert the ‘unwrapped’ DER encoding of the RSA public key
    writer.writeBytes([UInt8](rsaPublicKey))

    // Insert ASN.1 BIT STRING length and identifier bytes on top of it (as a wrapper)
    writer.wrapBitString()

    // Insert ASN.1 AlgorithmIdentifier bytes on top of it (as a sibling)
    writer.writeBytes(algorithmIdentifierForRSAEncryption)

    // Insert ASN.1 SEQUENCE length and identifier bytes on top it (as a wrapper)
    writer.wrap(with: sequenceIdentifier)

    return Data(writer.encoding)
  }
}
