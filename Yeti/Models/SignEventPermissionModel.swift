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
    var allowed: Bool

    init(kind: Int, allowed: Bool) {
        self.kind = kind
        self.allowed = allowed
    }
}
