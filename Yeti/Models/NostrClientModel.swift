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

    var readPublicKeyPermission: Bool?
    var nip04EncryptPermission: Bool?
    var nip44EncryptPermission: Bool?
    var nip04DencryptPermission: Bool?
    var nip44DencryptPermission: Bool?
    var getRelaysPermission: Bool?
    var decryptZapEventPermission: Bool?

    init(id: String) {
        self.id = id
    }
}
