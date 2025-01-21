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

    var body: some View {
//        OnboardingView()
        LoggedInView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SigningPolicyModel.self, inMemory: true)
}
