//
//  AddKeyView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/19/25.
//

import Combine
import NostrSDK
import SwiftUI

struct AddKeyView: View {
    @State private var keypair: Keypair?
    @State private var nostrIdentifier: String = ""

    @State private var navigationDestinationPresented: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Text("Add your key", comment: "Title of view to add the user’s private key.")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .listRowInsets(EdgeInsets())
                    .background(Color(UIColor.systemGroupedBackground))

                Section(
                    content: {
                        SecureField(
                            String(
                                localized: "nsec / private key",
                                comment: "Prompt asking user to enter in a Nostr private key."
                            ),
                            text: $nostrIdentifier
                        )
                        .autocorrectionDisabled(false)
                        .textContentType(.password)
                        .textInputAutocapitalization(.never)
                        .onReceive(Just(nostrIdentifier)) { newValue in
                            let filtered = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                            nostrIdentifier = filtered

                            self.keypair = Keypair(nsec: filtered)
                        }
                    },
                    footer: {
                        Text(
                            "Your private key is stored locally. Only you can see it.",
                            comment:
"""
Footer text explaining that the private key is stored locally and only the user can see it.
"""
                        )
                    }
                )

                Button("Next", action: {
                    navigationDestinationPresented = true
                })
                .disabled(!validPrivateKey)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground))
            }
            .navigationDestination(isPresented: $navigationDestinationPresented) {
                if let keypair {
                    SigningPolicySelectionView(keypair: keypair)
                }
            }
        }
    }

    private var validPrivateKey: Bool {
        keypair != nil
    }
}

#Preview {
    AddKeyView()
}
