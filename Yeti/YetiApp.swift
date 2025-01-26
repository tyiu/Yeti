//
//  YetiApp.swift
//  Yeti
//
//  Created by Terry Yiu on 1/19/25.
//

import NostrSDK
import SwiftUI
import SwiftData

@main
struct YetiApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    private let modelContainer: ModelContainer

    init() {
        modelContainer = createYetiModelContainer()

        var descriptor = FetchDescriptor<GeneralSettingsModel>()
        descriptor.fetchLimit = 1

        if let generalSettingsModel = (try? modelContainer.mainContext.fetch(descriptor))?.first,
           let activePublicKey = generalSettingsModel.activePublicKey,
           let publicKey = PublicKey(hex: activePublicKey) {
            print("Found pubkey=\(PrivateKeySecureStorage.shared.keypair(for: publicKey)?.publicKey.npub ?? "")")
        } else {
            let newGeneralSettingsModel = GeneralSettingsModel()
            modelContainer.mainContext.insert(newGeneralSettingsModel)
            do {
                try modelContainer.mainContext.save()
            } catch {
                fatalError("Unable to save initial GeneralSettingsModel.")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
