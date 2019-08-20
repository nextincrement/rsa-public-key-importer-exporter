//
//  main.swift
//  rsa-public-key-importer-exporter
//
//  Created by nextincrement on 27/07/2019.
//  Copyright © 2019 nextincrement
//

import Foundation
import RSAPublicKeyImporter
import RSAPublicKeyExporter

func printAsHexString(_ data: Data) {
  print(data.map{ String(format: "%02x ", $0) }.joined())
}

// A Base64 encoded public key created with OpenSSL
let x509EncodedKeyBase64 = """
  MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3o1GZDe0ivcgcWetu82mX+G7G5P9Ztsq5xptSmzL36mfyxUjrctA2\
  MCY0n604s5Gmv3hrrYgUiRndhmITPngnXiKUst+CV4uWEcwqe3qHRfrTXcCMhsOLd8OPmOkOHlsXwwM1OOGnHeQd5bRkCt43h\
  aSMrv55LeHH7JRo7+d9b08G04Ih1PAHzQCgfkwgJK+M5fU0k+sP4qeKcj3iFanGkCkl0eVcVbEoW7E9dQfg1VBT+DKbioW3xI\
  mBc2Rw+fo2j2gPVNKqvYGXEj3INvEgPxNtqk4DJ4DC+1FyYu94XM/qEVUQ8fKX0kzmDoDQ2WCFBbzO+yCLqpMiscgBH9XpwID\
  AQAB
  """

print("\nX.509 encoded RSA public key as a Base64 string:")
print(x509EncodedKeyBase64)

let x509EncodedKey = Data(base64Encoded: x509EncodedKeyBase64, options: [])!
print("\n...same X.509 encoded RSA public key as an array of hex values:")
printAsHexString(x509EncodedKey)

// Convert SubjectPublicKeyInfo to RSAPublicKey
let rsaPublicKey = try RSAPublicKeyImporter().fromSubjectPublicKeyInfo(x509EncodedKey)
print ("\nResult of a call to the fromSubjectPublicKeyInfo(_:) function as an array of hex values:")
printAsHexString(rsaPublicKey)

print("\n...same result as a Base64 string:")
print(rsaPublicKey.base64EncodedString(options: []))

// Convert RSAPublicKey to SubjectPublicKeyInfo
let x509EncodedKey2 = RSAPublicKeyExporter().toSubjectPublicKeyInfo(rsaPublicKey)
print("\nResult of a call to the toSubjectPublicKeyInfo(_:) function as an array of hex values:")
printAsHexString(x509EncodedKey2)

print("\n...same result as a Base64 string:")
print(x509EncodedKey2.base64EncodedString(options: []))

if x509EncodedKey == x509EncodedKey2 {
  print("\nSuccess!")
} else {
  print("\nFailure")
}
