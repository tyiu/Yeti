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
            if generalSettingsModels.first!.activePublicKey == nil {
                OnboardingView()
            } else {
                LoggedInView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ProfileSettingsModel.self, inMemory: true)
}
