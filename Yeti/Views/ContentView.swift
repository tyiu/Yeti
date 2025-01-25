//
//  ContentView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/19/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var generalSettingsModels: [GeneralSettingsModel]

    var body: some View {
        Group {
            if let activePublicKey = generalSettingsModels.first?.activePublicKey {
                LoggedInView(publicKey: activePublicKey)
            } else {
                OnboardingView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GeneralSettingsModel.self, inMemory: true)
}
