//
//  YetiApp.swift
//  Yeti
//
//  Created by Terry Yiu on 1/19/25.
//

import SwiftUI
import SwiftData

@main
struct YetiApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    private let modelContainer: ModelContainer

    init() {
        let schema = Schema([
            GeneralSettingsModel.self,
            ProfileSettingsModel.self,
            SignerRequestModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }

        var descriptor = FetchDescriptor<GeneralSettingsModel>()
        descriptor.fetchLimit = 1

        if (try? modelContainer.mainContext.fetch(descriptor))?.first == nil {
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
