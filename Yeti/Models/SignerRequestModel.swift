//
//  SignerRequestModel.swift
//  Yeti
//
//  Created by Terry Yiu on 1/22/25.
//

import Foundation
import SwiftData

@Model
final class SignerRequestModel {
    var type: NostrSignerType
    var returnType: NostrSignerReturnType
    var compressionType: NostrSignerCompressionType
    var createdAt: Date
    var callbackURL: String?
    var pubkey: String?
    var sourceApplication: String?
    var targetApplication: String?
    var approved: Bool?
    var decidedAt: Date?

    init(
        type: NostrSignerType,
        returnType: NostrSignerReturnType,
        compressionType: NostrSignerCompressionType,
        createdAt: Date,
        callbackURL: String? = nil,
        pubkey: String? = nil,
        sourceApplication: String? = nil,
        targetApplication: String? = nil,
        approved: Bool? = nil,
        decidedAt: Date? = nil
    ) {
        self.type = type
        self.returnType = returnType
        self.compressionType = compressionType
        self.createdAt = createdAt
        self.callbackURL = callbackURL
        self.pubkey = pubkey
        self.sourceApplication = sourceApplication
        self.targetApplication = targetApplication
        self.approved = approved
        self.decidedAt = decidedAt
    }
}

enum NostrSignerType: String, Codable, CaseIterable {
    case getPublicKey = "get_public_key"
    case signEvent = "sign_event"
    case nip04Encrypt = "nip04_encrypt"
    case nip44Encrypt = "nip44_encrypt"
    case nip04Decrypt = "nip04_decrypt"
    case nip44Decrypt = "nip44_decrypt"
    case getRelays = "get_relays"
    case decryptZapEvent = "decrypt_zap_event"
}

enum NostrSignerReturnType: String, Codable {
    case signature
    case event
}

enum NostrSignerCompressionType: String, Codable {
    case none
    case gzip
}
