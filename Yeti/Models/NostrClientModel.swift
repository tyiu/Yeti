//
//  NostrClientModel.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import Foundation
import SwiftData

@Model
final class NostrClientModel {
    @Attribute(.unique) var id: String

    @Relationship(deleteRule: .cascade) var signEventPermissions: [SignEventPermissionModel] = []

    var signingPolicy: SigningPolicy?

    var readPublicKeyPermission: Bool = false
    var nip04EncryptPermission: Bool = false
    var nip44EncryptPermission: Bool = false
    var nip04DecryptPermission: Bool = false
    var nip44DecryptPermission: Bool = false
    var getRelaysPermission: Bool = false
    var decryptZapEventPermission: Bool = false

    init(id: String) {
        self.id = id
    }
}
