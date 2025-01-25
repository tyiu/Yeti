//
//  SigningPolicy.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import Foundation

enum SigningPolicy: Codable, CaseIterable {
    case basic
    case manual

    var name: String {
        switch self {
        case .basic:
            return String(
                localized: "Approve basic actions",
                comment: "Name of event signing policy that approves basic actions."
            )
        case .manual:
            return String(
                localized: "Manually approve each app",
                comment: "Name of event signing policy that requires manual approval to sign each event."
            )
        }
    }

    var description: String {
        switch self {
        case .basic:
            return String(
                localized:
"""
Recommended for most people. This policy will minimize the number of interruptions during your app usage.
""",
                comment: "Description of event signing policy that approves basic actions."
            )
        case .manual:
            return String(
                localized:
"""
Recommended for privacy-minded people who would like control over each app.
Choosing this policy will prompt you to set a preference every time you try a new app.
""",
                comment: "Description of event signing policy that requires manual approval to sign each event."
            )
        }
    }
}
