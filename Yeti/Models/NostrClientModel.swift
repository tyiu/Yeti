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
    @Attribute(.unique) var name: String

    @Relationship(deleteRule: .cascade) var signEventPermissions: [SignEventPermissionModel] = []

    var readPublicKeyPermission: Bool = false
    var nip04EncryptPermission: Bool = false
    var nip44EncryptPermission: Bool = false
    var nip04DecryptPermission: Bool = false
    var nip44DecryptPermission: Bool = false
    var getRelaysPermission: Bool = false
    var decryptZapEventPermission: Bool = false

    init(name: String) {
        self.name = name
    }
}
