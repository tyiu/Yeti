//
//  PrivateKeySecureStorage.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import Foundation
import NostrSDK

class PrivateKeySecureStorage {

    static let shared = PrivateKeySecureStorage()

    private let service = "yeti-private-keys"
    private let accessGroup = "S99A5B637C.xyz.tyiu.Yeti.SharedKeychain"

    func keypair(for publicKey: PublicKey) -> Keypair? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: publicKey.hex,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecAttrAccessGroup: accessGroup
        ] as [CFString: Any] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        if status == errSecSuccess,
           let data = result as? Data,
           let privateKeyHex = String(data: data, encoding: .utf8) {
            return Keypair(hex: privateKeyHex)
        } else {
            return nil
        }
    }

    func store(for keypair: Keypair) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: keypair.publicKey.hex,
            kSecClass: kSecClassGenericPassword,
            kSecValueData: keypair.privateKey.hex.data(using: .utf8) as Any,
            kSecAttrAccessGroup: accessGroup
        ] as [CFString: Any] as CFDictionary

        var status = SecItemAdd(query, nil)

        switch status {
        case errSecDuplicateItem:
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: keypair.publicKey.hex,
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccessGroup: accessGroup
            ] as [CFString: Any] as CFDictionary

            let updates = [
                kSecValueData: keypair.privateKey.hex.data(using: .utf8) as Any
            ] as CFDictionary

            status = SecItemUpdate(query, updates)
        case errSecSuccess:
            print("Successfully stored keypair.")
        case errSecMissingEntitlement:
            print("Missing entitlement error while storing keypair.")
        default:
            print("Error storing keypair: \(status)")
        }
    }

    func delete(for publicKey: PublicKey) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: publicKey.hex,
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccessGroup: accessGroup
        ] as [CFString: Any] as CFDictionary

        _ = SecItemDelete(query)
    }
}
