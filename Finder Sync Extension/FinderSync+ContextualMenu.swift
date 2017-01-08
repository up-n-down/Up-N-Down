//
//  FinderSync+ContextualMenu.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 05/12/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import FinderSync

extension FinderSync {

    /// Returns a contextual menu.
    func createContextualMenu() -> NSMenu {
        // Todo: What do we do with directories?! Recursive I guess.

        let selectedItems = finderSyncController.selectedItemsRepresentation

        let commitMenuItem = NSMenuItem(title: "Commit \(selectedItems)",            action: #selector(commitDidPress(_:)))
        let addMenuItem    = NSMenuItem(title: "Add \(selectedItems) to Index",      action: #selector(addDidPress(_:)))
        let removeMenuItem = NSMenuItem(title: "Remove \(selectedItems) from Index", action: #selector(removeDidPress(_:)))
        let ignoreMenuItem = NSMenuItem(title: "Ignore \(selectedItems) in Index",   action: #selector(ignoreDidPress(_:)))


        let contextualMenu = NSMenu(title: "Contextual menu")
        contextualMenu.addItem(commitMenuItem)
        contextualMenu.addItem(addMenuItem)
        contextualMenu.addItem(removeMenuItem)
        contextualMenu.addItem(ignoreMenuItem)

        return contextualMenu
    }

    // MARK: - Actions

    @IBAction func commitDidPress(_ menuItem: NSMenuItem) {
        // TODO: Make it more beautiful.
        guard let targetedURL = finderSyncController.selectedItemURLs()?.first else {
            return
        }

        NSAlert.ask(for: "Commit Changes",
                    message: "Enter a Commit Message:",
                    actionButtonTitle: "Commit",
                    inputTextFieldPlaceholder: "Commit ...",
                    completionHandler: { [weak self] response, textfield in
                        guard response == NSAlertFirstButtonReturn else {
                            return
                        }

                        let commitMessage = textfield.stringValue
                        self?.git.commit(commitMessage, inRepository: targetedURL) { error in
                            if let error = error {
                                NSAlert.runModal(withError: error)
                            }
                        }
        })
    }

    @IBAction func addDidPress(_ menuItem: NSMenuItem) {
        finderSyncController.selectedItemURLs()?.forEach { file in
            git.add(toIndex: file) { [weak self] error in
                if let error = error {
                    NSAlert.runModal(withError: error)
                } else {
                    self?.requestBadgeIdentifier(for: file)
                }
            }
        }
    }

    @IBAction func removeDidPress(_ menuItem: NSMenuItem) {
        finderSyncController.selectedItemURLs()?.forEach { file in
            git.remove(fromIndex: file) { [weak self] error in
                if let error = error {
                    NSAlert.runModal(withError: error)
                } else {
                    self?.requestBadgeIdentifier(for: file)
                }
            }
        }
    }
    
    @IBAction func ignoreDidPress(_ menuItem: NSMenuItem) {
    }
    
}
