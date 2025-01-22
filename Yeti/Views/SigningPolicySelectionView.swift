//
//  SigningPolicySelectionView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import NostrSDK
import SwiftUI

struct SigningPolicySelectionView: View {
    let keypair: Keypair

    @State var signingPolicy: SigningPolicy = .basic

    @State private var navigationDestinationPresented: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Text("Select a signing policy", comment: "Title of view to select a signing policy.")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .listRowInsets(EdgeInsets())
                    .background(Color(UIColor.systemGroupedBackground))

                Text(
                    "Should I approve Nostr events automatically or would you like to review them for each app?",
                    comment: "Prompt asking user which signing policy to use."
                )
                .font(.caption)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground))

                Section(
                    content: {
                        Picker(
                            selection: $signingPolicy,
                            content: {
                                ForEach(SigningPolicy.allCases, id: \.self) { signingPolicy in
                                    Text(signingPolicy.name)
                                        .tag(signingPolicy)
                                }
                            },
                            label: {
                                EmptyView()
                            }
                        )
                        .pickerStyle(.inline)
                    },
                    footer: {
                        Text(signingPolicy.description)
                    }
                )

                Button("Done", action: {
                    navigationDestinationPresented = true
                })
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground))
            }
            .navigationDestination(isPresented: $navigationDestinationPresented) {
                SigningPolicyConfirmationView(keypair: keypair, signingPolicy: signingPolicy)
            }
        }
    }
}

#Preview {
    SigningPolicySelectionView(keypair: Keypair()!)
}
