//
//  SigningPolicyConfirmationView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import SwiftUI

struct SigningPolicyConfirmationView: View {
    let signingPolicy: SigningPolicy

    var body: some View {
        VStack {
            Text("Hooo-raaaayyy!", comment: "Title of view that confirms the user’s selection of the signing policy.")
                .font(.title)

            switch signingPolicy {
            case .basic:
                Text(
"""
You’re all set! I’ll take care of most of the approval for you.
If I see an event I don’t recognize, I’ll ask you to review it.
""",
                    comment: "Description of what the user should expect after selecting the basic signing policy."
                )
                .font(.caption)
            case .manual:
                Text(
"""
You’re set for now. You’ll need to come back here with every new app and approve some Nostr events.
""",
                    comment: "Description of what the user should expect after selecting the manual signing policy."
                )
                .font(.caption)
            }
        }
        .toolbar(.hidden)
    }
}

#Preview {
    SigningPolicyConfirmationView(signingPolicy: .basic)
}
