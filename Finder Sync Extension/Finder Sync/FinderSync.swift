//
//  FinderSync.swift
//  Up N Down Finder Sync Extension
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

    // MARK: - Properties

    fileprivate let badges: [Badge] = [
        .ignored,
        .addedInIndex, .deletedInIndex, .modifiedInIndex, .renamedInIndex,
        .addedInWorktree, .deletedInWorktree, .modifiedInWorktree, .renamedInWorktree
    ]

    fileprivate let directoryURL = URL(fileURLWithPath: "/")

    fileprivate let finderController = FIFinderSyncController.default()
    fileprivate let git = Git()

    // MARK: - Initializer

    override init() {
        super.init()

        // Set up the directory we are syncing.
        finderController.directoryURLs = [directoryURL]

        // Set up images for our badge identifiers.
        badges.forEach { finderController.register($0) }
    }

    // MARK: - Menu

    override func menu(for menu: FIMenuKind) -> NSMenu? {
        switch menu {
        case .toolbarItemMenu:
            return createToolbarMenu()
        default:
            return nil
        }
    }

}

// MARK: - Observation

extension FinderSync {

    override func beginObservingDirectory(at url: URL) {
        // The user is now seeing the container's contents.
        // If they see it in more than one view at a time, we're only told once.
        NSLog("Begin observing directory at \(url.path)")

        url.recursive { [weak self] url in
            do {
                try self?.git.openRepository(at: url)
                return true
            } catch _ {
                return false
            }
        }
    }

    override func requestBadgeIdentifier(for url: URL) {
        NSLog("Request badge identifier for \(url.path)")

        // If the URL points to a directory, do nothing.
        guard !url.hasDirectoryPath else {
            // TODO: Check recursively files in directory.
            return
        }

        // Retrieve status of file and set badge if necessary.
        if let status = git.status(for: url) {
            setBadgeIdentifier(for: status, forURL: url)

            NSLog("Status \(status) for \(url.path)")
        }
    }

    override func endObservingDirectory(at url: URL) {
        // The user is no longer seeing the container's contents.
        NSLog("End observing directory at \(url.path)")
    }

}

// MARK: - Toolbar 

extension FinderSync {

    override var toolbarItemName: String {
        return "Up-N-Down"
    }

    override var toolbarItemImage: NSImage {
        return NSImage(named: "Repository")!
    }

    override var toolbarItemToolTip: String {
        return "Perform tasks in you GIT Repository"
    }

    func createToolbarMenu() -> NSMenu {
        let toolbarMenu = NSMenu(title: "Toolbar menu")
//        let createRepositoryMenuItem = NSMenuItem(title: "Create Repository", action: #selector(FinderSync.createRepositoryDidPress(menuItem:)))

//        toolbarMenu.addItem(createRepositoryMenuItem)

        return toolbarMenu
    }

    @IBAction func createRepositoryDidPress(_ menuItem: NSMenuItem) {
        if let url = finderController.targetedURL(), url.hasDirectoryPath {
            do {
                try git.createRepository(at: url)
            } catch let error {
                NSLog("⚠️ Error \(error)")
            }
        }
    }

}

// MARK: - Git

extension FinderSync {

    /// Set Badge Identifier corresponding to Git Status
    func setBadgeIdentifier(for status: GitStatus, forURL url: URL) {
        switch status {
        case .addedInIndex:
            finderController.setBadgeIdentifier(Badge.addedInIndex.identifier, for: url)
            break
        case .addedInWorktree:
            finderController.setBadgeIdentifier(Badge.addedInWorktree.identifier, for: url)
            break
        case .deletedInIndex:
            finderController.setBadgeIdentifier(Badge.deletedInIndex.identifier, for: url)
            break
        case .deletedInWorktree:
            finderController.setBadgeIdentifier(Badge.deletedInWorktree.identifier, for: url)
            break
        case .modifiedInIndex:
            finderController.setBadgeIdentifier(Badge.modifiedInIndex.identifier, for: url)
            break
        case .modifiedInWorktree:
            finderController.setBadgeIdentifier(Badge.modifiedInWorktree.identifier, for: url)
            break
        case .renamedInIndex:
            finderController.setBadgeIdentifier(Badge.renamedInIndex.identifier, for: url)
            break
        case .renamedInWorktree:
            finderController.setBadgeIdentifier(Badge.renamedInWorktree.identifier, for: url)
            break
        case .ignored:
            finderController.setBadgeIdentifier(Badge.ignored.identifier, for: url)
            break
        case .unmodified:
            // Do nothing
            break
        }
    }
    
}

