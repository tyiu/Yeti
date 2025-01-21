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

    init(publicKey: String) {
        self.publicKey = publicKey
    }
}
