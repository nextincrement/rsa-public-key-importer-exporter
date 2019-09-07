//
//  RSAPublicKeyExporting.swift
//  rsa-public-key-importer-exporter
//
//  Created by nextincrement on 27/07/2019.
//  Copyright © 2019 nextincrement
//

import Foundation

/// The `RSAPublicKeyExporting` protocol defines how to convert the DER encoding of an RSA
/// public key to a format typically used by tools and programming languages outside the iOS
/// ecosystem (e.g. OpenSSL, Java, PHP and Perl). The DER encoding of an RSA public key created
/// by iOS is represented with the ASN.1 RSAPublicKey type as defined by PKCS #1. However, many
/// systems outside the Apple ecosystem expect the DER encoding of a key to be represented with
/// the ASN.1 SubjectPublicKeyInfo type as defined by X.509. The types are related in a way that
/// if the algorithm field of the SubjectPublicKeyInfo type contains the rsaEncryption object
/// identifier as defined by PKCS #1, the subjectPublicKey field shall contain the DER encoding
/// of an RSA key that is represented with the RSAPublicKey type.
///
/// ### Security Considerations
/// If exchanging bare public keys over a network (that is, without using a verified certificate),
/// consider setting up a TLS secured connection before sending any (additional) keys. And if
/// exchanging bare public keys more than once, e.g. after enrolling the app, consider using an
/// additional encryption layer on top of TLS. In any case, the encryption algorithm used in the
/// encryption process must be as ‘strong’ as the keys that are sent.
public protocol RSAPublicKeyExporting {

  /// This method converts a BER encoding of an RSA public key that is represented with the
  /// ASN.1 RSAPublicKey type, to a BER encoding that is represented with the ASN.1
  /// SubjectPublicKeyInfo type.
  ///
  /// Note that the parameter is assumed to be DER encoded, and if this assumption is correct, the
  /// result will be DER encoded as well. However, it will not be verified that the provided key
  /// is in fact DER encoded.
  ///
  /// - Parameter rsaPublicKey: A data object containing the DER (or BER) encoding of an RSA
  ///     public key, which is represented with the ASN.1 RSAPublicKey type.
  /// - Returns: A data object containing the DER (or BER) encoding of an RSA public key,
  ///     which is represented with the ASN.1 SubjectPublicKeyInfo type.
  func toSubjectPublicKeyInfo(_ rsaPublicKey: Data) -> Data
}
