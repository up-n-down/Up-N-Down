//
//  FinderSync+Git.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import FinderSync

extension FinderSync {

    /// Set Badge Identifier corresponding to Git Status
    func setBadgeIdentifier(for status: GitStatus, forURL url: URL) {
        switch status {
        case .addedInIndex:
            finderSyncController.setBadgeIdentifier(Badge.addedInIndex.identifier, for: url)
            break
        case .addedInWorktree:
            finderSyncController.setBadgeIdentifier(Badge.addedInWorktree.identifier, for: url)
            break
        case .deletedInIndex:
            finderSyncController.setBadgeIdentifier(Badge.deletedInIndex.identifier, for: url)
            break
        case .deletedInWorktree:
            finderSyncController.setBadgeIdentifier(Badge.deletedInWorktree.identifier, for: url)
            break
        case .modifiedInIndex:
            finderSyncController.setBadgeIdentifier(Badge.modifiedInIndex.identifier, for: url)
            break
        case .modifiedInWorktree:
            finderSyncController.setBadgeIdentifier(Badge.modifiedInWorktree.identifier, for: url)
            break
        case .renamedInIndex:
            finderSyncController.setBadgeIdentifier(Badge.renamedInIndex.identifier, for: url)
            break
        case .renamedInWorktree:
            finderSyncController.setBadgeIdentifier(Badge.renamedInWorktree.identifier, for: url)
            break
        case .ignored:
            finderSyncController.setBadgeIdentifier(Badge.ignored.identifier, for: url)
            break
        case .unmodified:
            // Do nothing
            break
        }
    }
}
