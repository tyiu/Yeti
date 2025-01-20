//
//  SceneDelegate.swift
//  Yeti
//
//  Created by Terry Yiu on 1/19/25.
//

import Foundation
import UIKit

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let urlContext = connectionOptions.urlContexts.first {
            self.scene(scene, openURLContext: urlContext)
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let urlContext = URLContexts.first {
            self.scene(scene, openURLContext: urlContext)
        }
    }

    private func scene(_ scene: UIScene, openURLContext: UIOpenURLContext) {
        let sendingAppID = openURLContext.options.sourceApplication
        let url = openURLContext.url

        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
              components.scheme == "nostrsigner",
              let queryItems = components.queryItems else {
            print("Invalid URL or path missing")
            return
        }

        print("source application = \(sendingAppID ?? "Unknown")")
        print("url = \(url)")

        if let path = components.path {
            print("path = \(path)")
        }
        if let host = components.host {
            print("host = \(host)")
        }

        print("queryItems = \(queryItems)")

        let params = queryItems.reduce(into: [:]) { $0[$1.name] = $1.value }

        let compressionType: NostrSignerCompressionType
        if let rawCompressionType = params["compressionType"] {
            if let maybeCompressionType = NostrSignerCompressionType(rawValue: rawCompressionType) {
                compressionType = maybeCompressionType
            } else {
                return
            }
        } else {
            compressionType = .none
        }

        guard let rawType = params["type"],
              let type = NostrSignerType(rawValue: rawType),
              let rawReturnType = params["returnType"],
              let returnType = NostrSignerReturnType(rawValue: rawReturnType) else {
            return
        }

        print("type = \(type)")
        print("returnType = \(returnType)")
        print("compressionType = \(compressionType)")

        if let pubkey = params["pubkey"] {
            print("pubkey = \(pubkey)")
        }

        if let callbackURL = params["callbackUrl"] {
            print("callbackURL = \(callbackURL)")
        }
    }
}

enum NostrSignerType: String, CaseIterable {
    case getPublicKey = "get_public_key"
    case signEvent = "sign_event"
    case nip04Encrypt = "nip04_encrypt"
    case nip44Encrypt = "nip44_encrypt"
    case nip04Decrypt = "nip04_decrypt"
    case nip44Decrypt = "nip44_decrypt"
    case getRelays = "get_relays"
    case decryptZapEvent = "decrypt_zap_event"
}

enum NostrSignerReturnType: String, CaseIterable {
    case signature
    case event
}

enum NostrSignerCompressionType: String, CaseIterable {
    case none
    case gzip
}
