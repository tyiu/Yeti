//
//  LoggedInView.swift
//  Yeti
//
//  Created by Terry Yiu on 1/20/25.
//

import NostrSDK
import SwiftData
import SwiftUI

struct LoggedInView: View {
    let publicKey: String

    @State var selectedTab: YetiTab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(YetiTab.allCases, id: \.self) { yetiTab in
                Tab(yetiTab.description, systemImage: yetiTab.systemImage, value: yetiTab) {
                    switch yetiTab {
                    case .home:
                        HomeView()
                    case .permissions:
                        PermissionsView(publicKey: publicKey)
                    case .history:
                        HistoryView()
                    case .settings:
                        SettingsView()
                    }
                }
            }
        }
    }
}

enum YetiTab: CustomStringConvertible, CaseIterable {
    case home
    case permissions
    case history
    case settings

    var description: String {
        switch self {
        case .home:
            String(localized: "Home", comment: "Title for Home tab")
        case .permissions:
            String(localized: "Permissions", comment: "Title for Permissions tab")
        case .history:
            String(localized: "History", comment: "Title for History tab")
        case .settings:
            String(localized: "Settings", comment: "Title for Settings tab")
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            "house"
        case .permissions:
            "shield.lefthalf.filled.badge.checkmark"
        case .history:
            "clock"
        case .settings:
            "gear"
        }
    }
}

#Preview {
    LoggedInView(publicKey: Keypair()!.publicKey.hex)
}
