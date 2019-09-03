//
//  RSAPublicKeyImporting.swift
//  rsa-public-key-importer-exporter
//
//  Created by nextincrement on 27/07/2019.
//  Copyright © 2019 nextincrement
//

import Foundation

/// The `RSAPublicKeyImporting` protocol defines how to convert the DER encoding of an RSA
/// public key from a format typically used by tools and programming languages outside the Apple
/// ecosystem (e.g. OpenSSL, Java, PHP and Perl) to the _default_ format used by Apple. The DER
/// encoding of an RSA public key created by iOS is represented with the ASN.1 RSAPublicKey type
/// as defined by PKCS#1. However, many systems outside the Apple ecosystem expect the DER
/// encoding of a key to be represented with the ASN.1 SubjectPublicKeyInfo type as defined by
///  X.509. The types are related in a way that if the algorithm field of the
/// SubjectPublicKeyInfo type contains the rsaEncryption object identifier as defined by
/// PKCS#1, the subjectPublicKey field shall contain the DER encoding of an RSA key that is
/// represented with the RSAPublicKey type.
///
/// ## General Considerations
/// Keep in mind that both encoding formats are in fact supported by the Apple ecosystem when
/// _importing_ an RSA public key. And this module is actually kind of redundant in that sense.
/// However, the main purpose of this protocol and its accompanying implementation is to show how
/// the `SimpleASN1Reader` can be used.
///
/// ## Security Considerations
/// If exchanging bare public keys over a network (that is, without using a verified certificate),
/// consider setting up a TLS secured connection before sending any (additional) keys. And if
/// exchanging bare public keys more than once, e.g. after enrolling the app, consider using an
/// additional encryption layer on top of TLS. In any case, the encryption algorithm used in the
/// encryption process must be as ‘strong’ as the keys that are sent.
public protocol RSAPublicKeyImporting {

  /// This method converts a DER encoding of an RSA public key that is represented with the
  /// ASN.1 SubjectPublicKeyInfo type to a DER encoding that is represented with the
  /// ASN.1 RSAPublicKey type.
  ///
  /// Note that it will not be verified that the provided key has a DER encoding format. If This
  /// key has not been DER encoded, the result will simply not be DER encoded as well.
  ///
  /// - Parameter subjectPublicKeyInfo: `Data` object containing the DER encoding of an RSA
  ///     public key, represented with the ASN.1 SubjectPublicKeyInfo type
  ///
  /// - Returns: `Data` object containing the DER encoding of an RSA public key, represented
  ///     with the ASN.1 RSAPublicKey type
  func fromSubjectPublicKeyInfo(_ subjectPublicKeyInfo: Data) throws -> Data
}
