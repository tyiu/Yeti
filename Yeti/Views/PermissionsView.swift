//
//  PermissionsView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import SwiftData
import SwiftUI

struct PermissionsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \NostrClientModel.id) var nostrClientModels: [NostrClientModel]

    var body: some View {
        NavigationStack {
            List {
                ForEach(nostrClientModels, id: \.self) { nostrClientModel in
                    NavigationLink(
                        nostrClientModel.id,
                        destination: NostrClientView(nostrClientModelId: nostrClientModel.id)
                    )
                }
            }
        }
        // TODO Remove this dummy code
        .onAppear(perform: addNostrClientModel)
    }

    // TODO Remove this dummy code
    private func addNostrClientModel() {
        withAnimation {
            let newNostrClientModel = NostrClientModel(id: Date().timeIntervalSince1970.rounded().description)
            newNostrClientModel.signEventPermissions = [
                SignEventPermissionModel(kind: 1, allowed: true),
                SignEventPermissionModel(kind: 31923, allowed: true)
            ]
            modelContext.insert(newNostrClientModel)
        }
    }
}

#Preview {
    PermissionsView()
}
