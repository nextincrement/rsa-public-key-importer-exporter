# RSA Public Key Importer and Exporter

An importer and exporter for the `ASN.1 DER` encoding of an `RSA` public key.

[![Swift Version][swift-image]][swift-url] [![License][license-image]][license-url]

This project includes the `RSAPublicKeyImporter` and `RSAPublicKeyExporter` module, written in Swift and featuring an importer and exporter that can be used for converting the `ASN.1 DER` encoding of an `RSA` public key from and to a format typically used by tools and programming languages outside the Apple ecosystem (e.g. OpenSSL, Java, PHP and Perl).

_Note that built-in support for both encoding formats is actually quite solid in the Apple ecosystem, meaning that the `RSAPublicKeyImporter` module is kind of redundant in that sense. However, this module can be used for testing the `RSAPublicKeyExporter` module that has a real-world application (or at least as long as Apple has no built-in support for exporting RSA public keys). In any case, both modules are considered a basic example of how the `SimpleASN1Reader` and `SimpleASN1Writer` module in the [simple-asn1-reader-writer](https://github.com/nextincrement/simple-asn1-reader-writer) project can be used._

## Usage

`rsa-public-key-importer-exporter` is a SwiftPM project and can be built, tested and run using these commands:

```bash
$ swift build
$ swift test
$ swift run
```

To depend on `rsa-public-key-importer-exporter`, put the following in the `dependencies` of your `Package.swift`:

    .package(url: "https://github.com/nextincrement/rsa-public-key-importer-exporter.git", from: "0.0.2"),

Code Examples:

```swift
import RSAPublicKeyImporter

[...]

let subjectPublicKeyInfoData = [...]

let rsaPublicKeyData = try RSAPublicKeyImporter().fromSubjectPublicKeyInfo(subjectPublicKeyInfoData)
```

```swift
import RSAPublicKeyExporter

[...]

let rsaPublicKeyData = [...]

let subjectPublicKeyInfoData = RSAPublicKeyExporter().toSubjectPublicKeyInfo(rsaPublicKeyData)
```

#### Using the RSAPublicKeyImporter and RSAPublicKeyExporter Together

Create a public key (for example by using OpenSSL):

```bash
$ openssl genrsa -out key.pem 2048
$ openssl rsa -in key.pem -outform PEM -pubout -out public.pem
```

Extract the `Base64` encoded `DER` encoding from the `key.pem` file, paste it in [this file](https://github.com/nextincrement/rsa-public-key-importer-exporter/blob/master/Sources/RSAPublicKeyImportExportDemo/main.swift) (or simply keep the example key unchanged) and run the demo:

```bash
$ swift run
```

Expected output:

```
X.509 encoded RSA public key as a Base64 string:
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3o1GZDe0ivcgcWetu82mX+G7G5P9Ztsq5xptSmzL36mfyxUjrctA2MCY
0n604s5Gmv3hrrYgUiRndhmITPngnXiKUst+CV4uWEcwqe3qHRfrTXcCMhsOLd8OPmOkOHlsXwwM1OOGnHeQd5bRkCt43haSMrv5
5LeHH7JRo7+d9b08G04Ih1PAHzQCgfkwgJK+M5fU0k+sP4qeKcj3iFanGkCkl0eVcVbEoW7E9dQfg1VBT+DKbioW3xImBc2Rw+fo
2j2gPVNKqvYGXEj3INvEgPxNtqk4DJ4DC+1FyYu94XM/qEVUQ8fKX0kzmDoDQ2WCFBbzO+yCLqpMiscgBH9XpwIDAQAB

...same X.509 encoded RSA public key as an array of hex values:
30 82 01 22 30 0d 06 09 2a 86 48 86 f7 0d 01 01 01 05 00 03 82 01 0f 00 30 82 01 0a 02 82 01 01 00
de 8d 46 64 37 b4 8a f7 20 71 67 ad bb cd a6 5f e1 bb 1b 93 fd 66 db 2a e7 1a 6d 4a 6c cb df a9 9f
cb 15 23 ad cb 40 d8 c0 98 d2 7e b4 e2 ce 46 9a fd e1 ae b6 20 52 24 67 76 19 88 4c f9 e0 9d 78 8a
52 cb 7e 09 5e 2e 58 47 30 a9 ed ea 1d 17 eb 4d 77 02 32 1b 0e 2d df 0e 3e 63 a4 38 79 6c 5f 0c 0c
d4 e3 86 9c 77 90 77 96 d1 90 2b 78 de 16 92 32 bb f9 e4 b7 87 1f b2 51 a3 bf 9d f5 bd 3c 1b 4e 08
87 53 c0 1f 34 02 81 f9 30 80 92 be 33 97 d4 d2 4f ac 3f 8a 9e 29 c8 f7 88 56 a7 1a 40 a4 97 47 95
71 56 c4 a1 6e c4 f5 d4 1f 83 55 41 4f e0 ca 6e 2a 16 df 12 26 05 cd 91 c3 e7 e8 da 3d a0 3d 53 4a
aa f6 06 5c 48 f7 20 db c4 80 fc 4d b6 a9 38 0c 9e 03 0b ed 45 c9 8b bd e1 73 3f a8 45 54 43 c7 ca
5f 49 33 98 3a 03 43 65 82 14 16 f3 3b ec 82 2e aa 4c 8a c7 20 04 7f 57 a7 02 03 01 00 01

Result of a call to the fromSubjectPublicKeyInfo(_:) function as an array of hex values:
30 82 01 0a 02 82 01 01 00 de 8d 46 64 37 b4 8a f7 20 71 67 ad bb cd a6 5f e1 bb 1b 93 fd 66 db 2a
e7 1a 6d 4a 6c cb df a9 9f cb 15 23 ad cb 40 d8 c0 98 d2 7e b4 e2 ce 46 9a fd e1 ae b6 20 52 24 67
76 19 88 4c f9 e0 9d 78 8a 52 cb 7e 09 5e 2e 58 47 30 a9 ed ea 1d 17 eb 4d 77 02 32 1b 0e 2d df 0e
3e 63 a4 38 79 6c 5f 0c 0c d4 e3 86 9c 77 90 77 96 d1 90 2b 78 de 16 92 32 bb f9 e4 b7 87 1f b2 51
a3 bf 9d f5 bd 3c 1b 4e 08 87 53 c0 1f 34 02 81 f9 30 80 92 be 33 97 d4 d2 4f ac 3f 8a 9e 29 c8 f7
88 56 a7 1a 40 a4 97 47 95 71 56 c4 a1 6e c4 f5 d4 1f 83 55 41 4f e0 ca 6e 2a 16 df 12 26 05 cd 91
c3 e7 e8 da 3d a0 3d 53 4a aa f6 06 5c 48 f7 20 db c4 80 fc 4d b6 a9 38 0c 9e 03 0b ed 45 c9 8b bd
e1 73 3f a8 45 54 43 c7 ca 5f 49 33 98 3a 03 43 65 82 14 16 f3 3b ec 82 2e aa 4c 8a c7 20 04 7f 57
a7 02 03 01 00 01

...same result as a Base64 string:
MIIBCgKCAQEA3o1GZDe0ivcgcWetu82mX+G7G5P9Ztsq5xptSmzL36mfyxUjrctA2MCY0n604s5Gmv3hrrYgUiRndhmITPngnXiK
Ust+CV4uWEcwqe3qHRfrTXcCMhsOLd8OPmOkOHlsXwwM1OOGnHeQd5bRkCt43haSMrv55LeHH7JRo7+d9b08G04Ih1PAHzQCgfkw
gJK+M5fU0k+sP4qeKcj3iFanGkCkl0eVcVbEoW7E9dQfg1VBT+DKbioW3xImBc2Rw+fo2j2gPVNKqvYGXEj3INvEgPxNtqk4DJ4D
C+1FyYu94XM/qEVUQ8fKX0kzmDoDQ2WCFBbzO+yCLqpMiscgBH9XpwIDAQAB

Result of a call to the toSubjectPublicKeyInfo(_:) function as an array of hex values:
30 82 01 22 30 0d 06 09 2a 86 48 86 f7 0d 01 01 01 05 00 03 82 01 0f 00 30 82 01 0a 02 82 01 01 00
de 8d 46 64 37 b4 8a f7 20 71 67 ad bb cd a6 5f e1 bb 1b 93 fd 66 db 2a e7 1a 6d 4a 6c cb df a9 9f
cb 15 23 ad cb 40 d8 c0 98 d2 7e b4 e2 ce 46 9a fd e1 ae b6 20 52 24 67 76 19 88 4c f9 e0 9d 78 8a
52 cb 7e 09 5e 2e 58 47 30 a9 ed ea 1d 17 eb 4d 77 02 32 1b 0e 2d df 0e 3e 63 a4 38 79 6c 5f 0c 0c
d4 e3 86 9c 77 90 77 96 d1 90 2b 78 de 16 92 32 bb f9 e4 b7 87 1f b2 51 a3 bf 9d f5 bd 3c 1b 4e 08
87 53 c0 1f 34 02 81 f9 30 80 92 be 33 97 d4 d2 4f ac 3f 8a 9e 29 c8 f7 88 56 a7 1a 40 a4 97 47 95
71 56 c4 a1 6e c4 f5 d4 1f 83 55 41 4f e0 ca 6e 2a 16 df 12 26 05 cd 91 c3 e7 e8 da 3d a0 3d 53 4a
aa f6 06 5c 48 f7 20 db c4 80 fc 4d b6 a9 38 0c 9e 03 0b ed 45 c9 8b bd e1 73 3f a8 45 54 43 c7 ca
5f 49 33 98 3a 03 43 65 82 14 16 f3 3b ec 82 2e aa 4c 8a c7 20 04 7f 57 a7 02 03 01 00 01

...same result as a Base64 string:
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3o1GZDe0ivcgcWetu82mX+G7G5P9Ztsq5xptSmzL36mfyxUjrctA2MCY
0n604s5Gmv3hrrYgUiRndhmITPngnXiKUst+CV4uWEcwqe3qHRfrTXcCMhsOLd8OPmOkOHlsXwwM1OOGnHeQd5bRkCt43haSMrv5
5LeHH7JRo7+d9b08G04Ih1PAHzQCgfkwgJK+M5fU0k+sP4qeKcj3iFanGkCkl0eVcVbEoW7E9dQfg1VBT+DKbioW3xImBc2Rw+fo
2j2gPVNKqvYGXEj3INvEgPxNtqk4DJ4DC+1FyYu94XM/qEVUQ8fKX0kzmDoDQ2WCFBbzO+yCLqpMiscgBH9XpwIDAQAB

Success!
```

## Dependencies

`rsa-public-key-importer-exporter` depends on the following:

- [`simple-asn1-reader-writer`](https://github.com/nextincrement/simple-asn1-reader-writer), version 0.0.2 or better.
- Swift 5.0.

## Resources

[A Layman’s Guide to a Subset of ASN.1, BER, and DER](http://luca.ntop.org/Teaching/Appunti/asn1.html)

[X.690](https://www.itu.int/rec/T-REC-X.690-201508-I/en) (ASN.1 encoding formats: BER, DER and CER)

[RFC 5280](https://tools.ietf.org/html/rfc5280) (X.509 v3)

[RFC 8017](https://tools.ietf.org/html/rfc8017) (PKCS #1 v2.2)

## License

`rsa-public-key-importer-exporter` is licensed under the MIT License. See LICENSE for details.

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]:https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
