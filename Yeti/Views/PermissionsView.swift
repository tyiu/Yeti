//
//  PermissionsView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import NostrSDK
import SwiftData
import SwiftUI

struct PermissionsView: View {
    @Query var profileSettingsModels: [ProfileSettingsModel]

    init(publicKey: String) {
        var descriptor = FetchDescriptor<ProfileSettingsModel>(
            predicate: #Predicate { profileSettingsModel in
                profileSettingsModel.publicKey == publicKey
            }
        )
        descriptor.fetchLimit = 1

        self._profileSettingsModels = Query(descriptor)
    }

    var profileSettingsModel: ProfileSettingsModel? {
        profileSettingsModels.first
    }

    var nostrClientModels: [NostrClientModel] {
        profileSettingsModel?.nostrClientModels ?? []
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(nostrClientModels, id: \.self) { nostrClientModel in
                    NavigationLink(
                        nostrClientModel.name,
                        destination: NostrClientView(nostrClientModelName: nostrClientModel.name)
                    )
                }
            }
        }
    }
}

#Preview {
    PermissionsView(publicKey: Keypair()!.publicKey.hex)
}
