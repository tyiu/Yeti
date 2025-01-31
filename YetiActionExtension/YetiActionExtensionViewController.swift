//
//  YetiActionExtensionViewController.swift
//  YetiActionExtension
//
//  Created by Terry Yiu on 1/26/25.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers

class YetiActionExtensionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard
            let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
            let itemProvider = extensionItem.attachments?.first
        else {
            done()
            return
        }

        let textDataType = UTType.plainText.identifier
        guard itemProvider.hasItemConformingToTypeIdentifier(textDataType) else {
            done()
            return
        }

        itemProvider.loadItem(forTypeIdentifier: textDataType, options: nil) { (providedText, error) in
            if let error {
                self.done(signedEvent: error.localizedDescription)
                return
            }

            if let text = providedText as? String {
                DispatchQueue.main.async {
                    let contentView = UIHostingController(rootView: YetiActionExtensionView(text: text))
                    self.addChild(contentView)
                    self.view.addSubview(contentView.view)

                    // set up constraints
                    contentView.view.translatesAutoresizingMaskIntoConstraints = false
                    contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                    contentView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                    contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                    contentView.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
                }
            } else {
                self.done()
                return
            }
        }

        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("done"),
            object: nil,
            queue: nil
        ) { notification in
            DispatchQueue.main.async {
                self.done(signedEvent: notification.object as? String)
            }
        }
    }

    func done(signedEvent: String? = nil) {
        if let extensionContext = self.extensionContext {
            if let signedEvent {
                let itemProvider = NSItemProvider(
                    item: signedEvent as NSSecureCoding?,
                    typeIdentifier: UTType.text.identifier
                )
                let extensionItem = NSExtensionItem()
                extensionItem.attachments = [itemProvider]
                extensionContext.completeRequest(returningItems: [extensionItem], completionHandler: nil)
            } else {
                extensionContext.completeRequest(returningItems: [], completionHandler: nil)
            }
        }
    }

}
