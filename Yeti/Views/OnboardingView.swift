//
//  OnboardingView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            Text("Yeti: Nostr Helper", comment: "Application title.")

            HStack {
                NavigationLink(
                    destination: {
                        AddKeyView()
                    },
                    label: {
                        Text("Add a key", comment: "Button to add a key.")
                    }
                )
                .buttonStyle(.bordered)

                NavigationLink(
                    destination: {
                        AddKeyView()
                    },
                    label: {
                        Text("Create a key", comment: "Button to create a key.")
                    }
                )
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle(String(localized: "Home", comment: "Navigation title of home view."))
        .toolbar(removing: .title)
    }
}

#Preview {
    OnboardingView()
}
