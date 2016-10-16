//
//  Badge.swift
//  up-n-down
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import FinderSync

enum Badge: String {

    case ignored = "Ignored"

    case addedInIndex = "Added in Index"
    case deletedInIndex = "Deleted in Index"
    case modifiedInIndex = "Modified in Index"
    case renamedInIndex = "Renamed in Index"

    case addedInWorktree = "Added in Worktree"
    case deletedInWorktree = "Deleted in Worktree"
    case modifiedInWorktree = "Modified in Worktree"
    case renamedInWorktree = "Renamed in Worktree"

}

// MARK: - Convenience properties

extension Badge {

    /// Returns the identifier of the badge.
    var identifier: String {
        return self.rawValue
    }

    /// Returns the image of the badge.
    var image: NSImage {
        return NSImage(named: self.rawValue)!
    }
    
}
