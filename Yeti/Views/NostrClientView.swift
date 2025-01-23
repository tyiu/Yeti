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
                Toggle(
                    String(
                        localized: "Read your profile",
                        comment: "Permission toggle to allow Nostr client to read your profile."
                    ),
                    isOn: bindableNostrClientModel.readPublicKeyPermission
                )
                Toggle(
                    String(
                        localized: "Get relays",
                        comment: "Permission toggle to allow Nostr client to get relays."
                    ),
                    isOn: bindableNostrClientModel.getRelaysPermission
                )
                Toggle(
                    String(
                        localized: "Encrypt DMs",
                        comment: "Permission toggle to allow Nostr client to encrypt direct messages."
                    ),
                    isOn: bindableNostrClientModel.nip44EncryptPermission
                )
                Toggle(
                    String(
                        localized: "Decrypt DMs",
                        comment: "Permission toggle to allow Nostr client to decrypt direct messages."
                    ),
                    isOn: bindableNostrClientModel.nip44DecryptPermission
                )
                Toggle(
                    String(
                        localized: "Encrypt legacy DMs",
                        comment: "Permission toggle to allow Nostr client to encrypt legacy direct messages."
                    ),
                    isOn: bindableNostrClientModel.nip04EncryptPermission
                )
                Toggle(
                    String(
                        localized: "Decrypt legacy DMs",
                        comment: "Permission toggle to allow Nostr client to decrypt legacy direct messages."
                    ),
                    isOn: bindableNostrClientModel.nip04DecryptPermission
                )
                Toggle(
                    String(
                        localized: "Decrypt zap events",
                        comment: "Permission toggle to allow Nostr client to decrypt zap events."
                    ),
                    isOn: bindableNostrClientModel.decryptZapEventPermission
                )

                ForEach(bindableNostrClientModel.signEventPermissions, id: \.self) { signEventPermissionModel in
                    Toggle(
                        String(
                            localized: "Sign kind \(signEventPermissionModel.kind.wrappedValue.description) events",
                            comment: "Permission toggle to allow Nostr client to sign events of a specific kind.."
                        ),
                        isOn: signEventPermissionModel.allowed
                    )
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
