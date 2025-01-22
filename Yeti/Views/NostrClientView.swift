//
//  NostrClientView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/21/25.
//

import SwiftData
import SwiftUI

struct NostrClientView: View {
    @Query private var nostrClientModels: [NostrClientModel]

    init(nostrClientModelId: String) {
        self._nostrClientModels = Query(filter: #Predicate<NostrClientModel> {
            $0.id == nostrClientModelId
        })
    }

    var nostrClientModel: NostrClientModel {
        nostrClientModels.first!
    }

    var body: some View {
        VStack {
            let bindableNostrClientModel = Bindable(nostrClientModel)

            Text(bindableNostrClientModel.id)
                .font(.headline)

            List {
                Toggle("Read your profile", isOn: bindableNostrClientModel.readPublicKeyPermission)
                Toggle("Get relays", isOn: bindableNostrClientModel.getRelaysPermission)
                Toggle("Encrypt DMs", isOn: bindableNostrClientModel.nip44EncryptPermission)
                Toggle("Decrypt DMs", isOn: bindableNostrClientModel.nip44DecryptPermission)
                Toggle("Encrypt legacy DMs", isOn: bindableNostrClientModel.nip04EncryptPermission)
                Toggle("Decrypt legacy DMs", isOn: bindableNostrClientModel.nip04DecryptPermission)
                Toggle("Decrypt zap events", isOn: bindableNostrClientModel.decryptZapEventPermission)

                ForEach(bindableNostrClientModel.signEventPermissions, id: \.self) { signEventPermissionModel in
                    Toggle("Sign kind \(signEventPermissionModel.kind.wrappedValue.description) events", isOn: signEventPermissionModel.allowed)
                }
            }
        }
    }
}

extension NostrClientModel {
    static func predicateById(_ id: String) -> Predicate<NostrClientModel> {
        #Predicate<NostrClientModel> { nostrClientModel in
            nostrClientModel.id == id
        }
    }
}

#Preview {
    NostrClientView(nostrClientModelId: UUID().uuidString)
}
