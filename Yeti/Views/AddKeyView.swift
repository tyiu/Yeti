//
//  AddKeyView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/19/25.
//

import SwiftUI

struct AddKeyView: View {
    @State private var key: String = ""

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
                            text: $key
                        )
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

                NavigationLink(destination: SigningPolicySelectionView()) {
                    Text("Next", comment: "Button to go to the next view that adds the user’s entered private key.")
                }
            }
        }
    }
}

#Preview {
    AddKeyView()
}
