//
//  YetiSignerActionView.swift
//  YetiSignerAction
//
//  Created by Terry Yiu on 1/26/25.
//

import NostrSDK
import SwiftUI

struct YetiSignerActionView: View {
    @State private var text: String
    @State private var result: String = ""

    init(text: String) {
        self.text = text
    }

    var body: some View {
        EmptyView()
            .onAppear {
                do {
                    try sign()
                    done()
                } catch {
                    result = error.localizedDescription
                }
            }
    }

    func sign() throws {
        let data = Data(text.utf8)
        let unsignedNostrEvent = try JSONDecoder().decode(NostrEvent.self, from: data)
        let pubkey = unsignedNostrEvent.pubkey
        if let publicKey = PublicKey(hex: pubkey),
           let keypair = PrivateKeySecureStorage.shared.keypair(for: publicKey) {
            let signedNostrEvent = try NostrEvent.Builder(nostrEvent: unsignedNostrEvent)
                .build(signedBy: keypair)

            let encodedSignedEvent = try JSONEncoder().encode(signedNostrEvent)
            let encodedSignedEventString = String(data: encodedSignedEvent, encoding: .utf8)!

            self.result = encodedSignedEventString
        }
    }

    func done() {
        NotificationCenter.default.post(name: NSNotification.Name("done"), object: result)
    }
}

#Preview {
    YetiSignerActionView(text: "Hello, world!")
}
