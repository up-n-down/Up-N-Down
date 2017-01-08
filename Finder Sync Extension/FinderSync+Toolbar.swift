//
//  FinderSync+Toolbar.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 21/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import FinderSync
import Cocoa

extension FinderSync {

    // MARK: - Toolbar Item

    override var toolbarItemName: String {
        return "Up-N-Down"
    }

    override var toolbarItemImage: NSImage {
        return NSImage(named: "Repository")!
    }

    override var toolbarItemToolTip: String {
        return "Perform tasks on your GIT Repository."
    }

    /// Returns a toolbar menu.
    func createToolbarMenu() -> NSMenu {
        let createRepositoryMenuItem = NSMenuItem(
            title: "Create Repository",
            action: #selector(createRepositoryDidPress(_:))
        )

        let cloneRepositoryMenuItem = NSMenuItem(
            title: "Clone Repository",
            action: #selector(cloneRepositoryDidPress(_:))
        )

        let toolbarMenu = NSMenu(title: "Toolbar menu")
        toolbarMenu.addItem(createRepositoryMenuItem)
        toolbarMenu.addItem(cloneRepositoryMenuItem)

        return toolbarMenu
    }

    // MARK: - Actions

    @IBAction func createRepositoryDidPress(_ menuItem: NSMenuItem) {
        guard let url = finderSyncController.targetedURL(), url.hasDirectoryPath else {
            return
        }

        git.createRepository(at: url) { error in
            NSAlert.runModal(withError: error)
        }
    }

    @IBAction func cloneRepositoryDidPress(_ menuItem: NSMenuItem) {
        guard let url = finderSyncController.targetedURL(), url.hasDirectoryPath else {
            return
        }

        NSAlert.ask(for: "Clone Repository",
                    message: "Enter a Git URL:",
                    actionButtonTitle: "Clone",
                    inputTextFieldPlaceholder: "http://github.com/up-n-down/Up-N-Down",
                    completionHandler: { [weak self] response, textfield in
                        guard
                            response == NSAlertFirstButtonReturn,
                            let sourceURL = URL(string: textfield.stringValue),
                            let repoName = URL(string: textfield.stringValue)?.lastPathComponent
                        else {
                            return
                        }

                        let destinationURL = url.appendingPathComponent(repoName)

                        self?.git.cloneRepository(from: sourceURL, to: destinationURL) { error in
                            NSAlert.runModal(withError: error)
                        }
        })
    }
    
}

