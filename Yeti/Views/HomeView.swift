//
//  HomeView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Query(
        filter: #Predicate<SignerRequestModel> { signerRequestModel in
            signerRequestModel.approved == nil
        },
        sort: \SignerRequestModel.createdAt, order: .reverse
    )
    private var signerRequestModels: [SignerRequestModel]

    var body: some View {
        if let signerRequestModel = signerRequestModels.first {
            Section {
                VStack {
                    Text(signerRequestModel.type.rawValue)
                    Text(signerRequestModel.returnType.rawValue)
                    Text(signerRequestModel.compressionType.rawValue)
                    Text(signerRequestModel.createdAt.description)
                    Text(signerRequestModel.callbackURL ?? "Unknown callbackURL")
                    Text(signerRequestModel.pubkey ?? "Unknown pubkey")
                    Text(signerRequestModel.sourceApplication ?? "Unknown sourceApplication")
                    Text(signerRequestModel.targetApplication ?? "Unknown targetApplication")

                    HStack {
                        Button(
                            String(localized: "Allow", comment: "Button to allow a permission request."),
                            systemImage: "checkmark"
                        ) {
                            signerRequestModel.approved = true
                        }
                        .buttonStyle(.borderedProminent)

                        Button(
                            String(localized: "Deny", comment: "Button to deny a permission request."),
                            systemImage: "xmark"
                        ) {
                            signerRequestModel.approved = false
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        } else {
            VStack {
                Text(
                    "Nothing to approve yet",
                    comment:
"""
Text on Home tab to indicate that there are no permission requests to review for approval.
"""
                )
                .font(.headline)

                Text(
                    "Why not explore your favorite Nostr app a bit?",
                    comment:
"""
Text on Home tab to suggest what the user could do instead
since there are no permission requests to review for approval.
"""
                )
                .font(.caption)
            }
        }
    }
}

#Preview {
    HomeView()
}
