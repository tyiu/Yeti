//
//  SceneDelegate.swift
//  Yeti
//
//  Created by Terry Yiu on 1/19/25.
//

import Foundation
import SwiftData
import UIKit

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    private static let nostrSignerURLScheme = "nostrsigner"

    private let modelContainer: ModelContainer

    override init() {
        modelContainer = createYetiModelContainer()
    }

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
        var generalSettingsModelDescriptor = FetchDescriptor<GeneralSettingsModel>()
        generalSettingsModelDescriptor.fetchLimit = 1

        guard let generalSettingsModel = try? modelContainer.mainContext.fetch(generalSettingsModelDescriptor).first,
              let activePublicKey = generalSettingsModel.activePublicKey
        else {
            return
        }

        let sourceApplication = openURLContext.options.sourceApplication
        let url = openURLContext.url

        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
              components.scheme == SceneDelegate.nostrSignerURLScheme,
              let queryItems = components.queryItems else {
            print("Invalid URL or path missing. \(url.absoluteString)")
            return
        }

        let params = queryItems.reduce(into: [:]) { $0[$1.name] = $1.value }

        let compressionType: NostrSignerCompressionType
        if let rawCompressionType = params[NostrSignerURLQueryItemName.compressionType.rawValue] {
            if let maybeCompressionType = NostrSignerCompressionType(rawValue: rawCompressionType) {
                compressionType = maybeCompressionType
            } else {
                return
            }
        } else {
            compressionType = .none
        }

        guard let rawCommand = params[NostrSignerURLQueryItemName.type.rawValue],
              let command = NostrSignerCommand(rawValue: rawCommand),
              let rawReturnType = params[NostrSignerURLQueryItemName.returnType.rawValue],
              let returnType = NostrSignerReturnType(rawValue: rawReturnType)
        else {
            return
        }

        let callbackURLString = params[NostrSignerURLQueryItemName.callbackURL.rawValue]
        let targetApplication = targetApplication(callbackURLString)

        let pubkey = params[NostrSignerURLQueryItemName.pubkey.rawValue]

        let signerRequestModel = SignerRequestModel(
            command: command,
            requestType: .nostrSignerUrlScheme,
            returnType: returnType,
            compressionType: compressionType,
            createdAt: Date.now,
            callbackURL: callbackURLString,
            pubkey: pubkey,
            sourceApplication: sourceApplication,
            targetApplication: targetApplication
        )

        modelContainer.mainContext.insert(signerRequestModel)
    }

    private func targetApplication(_ callbackURLString: String?) -> String? {
        if let callbackURLString, let callbackURL = URL(string: callbackURLString) {
            if let scheme = callbackURL.scheme {
                let lowercasedScheme = scheme.lowercased()
                if lowercasedScheme == "http" || lowercasedScheme == "https" {
                    return callbackURL.host()
                } else {
                    return lowercasedScheme
                }
            }
        }
        return nil
    }
}

private enum NostrSignerURLQueryItemName: String {
    case callbackURL = "callbackUrl"
    case compressionType
    case pubkey
    case returnType
    case type
}
