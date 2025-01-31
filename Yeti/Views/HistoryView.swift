//
//  HistoryView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import SwiftData
import SwiftUI

struct HistoryView: View {
    @Query(sort: \SignerRequestModel.createdAt, order: .reverse) private var signerRequestModels: [SignerRequestModel]

    var body: some View {
        List {
            ForEach(signerRequestModels, id: \.self) { signerRequestModel in
                Section {
                    VStack {
                        Text(signerRequestModel.command.rawValue)
                        Text(signerRequestModel.requestType.rawValue)
                        Text(signerRequestModel.returnType.rawValue)
                        Text(signerRequestModel.compressionType.rawValue)
                        Text(signerRequestModel.createdAt.description)
                        Text(signerRequestModel.callbackURL ?? "Unknown callbackURL")
                        Text(signerRequestModel.pubkey ?? "Unknown pubkey")
                        Text(signerRequestModel.sourceApplication ?? "Unknown sourceApplication")
                        Text(signerRequestModel.targetApplication ?? "Unknown targetApplication")

                        switch signerRequestModel.approved {
                        case .none:
                            Text("Pending", comment: "Text indicating that a signer request is pending approval.")
                        case .some(let approved):
                            Text(
                                "Approved: \(approved.description)",
                                comment: "Text indicating that a signer request is either approved or not approved.")
                        }

                        Text(signerRequestModel.decidedAt?.description ?? "Unknown decisionTimestamp")
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryView()
}
