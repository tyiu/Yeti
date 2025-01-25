//
//  SignEventPermissionModel.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import Foundation
import SwiftData

@Model
final class SignEventPermissionModel {
    var kind: Int
    var approved: Bool

    init(kind: Int, approved: Bool) {
        self.kind = kind
        self.approved = approved
    }
}
