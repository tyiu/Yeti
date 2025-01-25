//
//  ProfileSettingsModel.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import Foundation
import SwiftData

@Model
final class ProfileSettingsModel {
    @Attribute(.unique) var publicKey: String

    var nostrClientModels: [NostrClientModel] = []
    var signingPolicy: SigningPolicy?

    init(publicKey: String) {
        self.publicKey = publicKey
    }
}

extension ProfileSettingsModel {
    static func predicateByPublicKey(_ publicKey: String) -> Predicate<ProfileSettingsModel> {
        #Predicate<ProfileSettingsModel> { profileSettingsModel in
            profileSettingsModel.publicKey == publicKey
        }
    }
}
