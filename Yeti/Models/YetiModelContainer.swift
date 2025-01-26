//
//  YetiModelContainer.swift
//  Yeti
//
//  Created by Terry Yiu on 1/27/25.
//

import SwiftData

public func createYetiModelContainer() -> ModelContainer {
    let schema = Schema([
        GeneralSettingsModel.self,
        ProfileSettingsModel.self,
        SignerRequestModel.self
    ])

    let modelConfiguration = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: false,
        cloudKitDatabase: .none
    )

    do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        fatalError("Could not create ModelContainer: \(error.localizedDescription)")
    }
}
