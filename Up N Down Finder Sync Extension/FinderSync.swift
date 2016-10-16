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

    fileprivate let badges: [Badge] = [
        .ignored,
        .addedInIndex, .deletedInIndex, .modifiedInIndex, .renamedInIndex,
        .addedInWorktree, .deletedInWorktree, .modifiedInWorktree, .renamedInWorktree
    ]

    private let usersDirectoryURL = URL(fileURLWithPath: "/Users/")
    fileprivate let finderController = FIFinderSyncController.default()

    override init() {
        super.init()

        // Set up the directory we are syncing.
        finderController.directoryURLs = [usersDirectoryURL]

        // Set up images for our badge identifiers.
        badges.forEach { finderController.register(badge: $0) }
    }

}

// MARK: - Observation

extension FinderSync {

    override func beginObservingDirectory(at url: URL) {
        // The user is now seeing the container's contents.
        // If they see it in more than one view at a time, we're only told once.
        NSLog("beginObservingDirectoryAtURL: %@", url.path as NSString)
    }

    override func requestBadgeIdentifier(for url: URL) {
        NSLog("requestBadgeIdentifierForURL: %@", url.path as NSString)

        // For demonstration purposes, this picks one of our two badges, or no badge at all, based on the filename.
        let whichBadge = abs(url.path.hash) % 3
        let badgeIdentifier = badges[whichBadge].identifier
        finderController.setBadgeIdentifier(badgeIdentifier, for: url)
    }

    override func endObservingDirectory(at url: URL) {
        // The user is no longer seeing the container's contents.
        NSLog("endObservingDirectoryAtURL: %@", url.path as NSString)
    }

}

