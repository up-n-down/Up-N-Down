//
//  FinderSync.swift
//  Up N Down Finder Sync Extension
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Cocoa
import FinderSync
import DirectoryMonitor

class FinderSync: FIFinderSync {

    fileprivate let badges: [Badge] = [
        .ignored,
        .addedInIndex, .deletedInIndex, .modifiedInIndex, .renamedInIndex,
        .addedInWorktree, .deletedInWorktree, .modifiedInWorktree, .renamedInWorktree
    ]

    private let usersDirectoryURL = URL(fileURLWithPath: "/Users/")
    fileprivate let finderController = FIFinderSyncController.default()
    fileprivate var currentDirectoryURL: URL?
    fileprivate var directoryMonitor: DirectoryMonitor?
    fileprivate var repository: Repository? {
        didSet {
            guard let directoryURL = repository?.repository.URL else {
                directoryMonitor?.stopMonitoring()
                return
            }

            directoryMonitor = DirectoryMonitor(at: directoryURL)
            directoryMonitor?.startMonitoring {
                NSLog("Directory did change at \(directoryURL)")
            }
        }
    }

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

        currentDirectoryURL = url

        url.recursive { [weak self] url in
            self?.repository = Repository(from: url)

            return self?.repository != nil
        }
    }

    override func requestBadgeIdentifier(for url: URL) {
        NSLog("requestBadgeIdentifierForURL: %@", url.path as NSString)

        // If the URL points to a directory, do nothing.
        guard !url.hasDirectoryPath else {
            // TODO: Check recursively files in directory.
            return
        }

        // Retrieve status of file and set badge if necessary.
        if let status = repository?.status(for: url) {
            setBadgeIdentifier(for: status, forURL: url)

            NSLog("Status \(status) for \(url.path)")
        }
    }

    override func endObservingDirectory(at url: URL) {
        currentDirectoryURL = nil

        // The user is no longer seeing the container's contents.
        NSLog("endObservingDirectoryAtURL: %@", url.path as NSString)
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

