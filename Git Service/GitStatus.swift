//
//  GitStatus.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 01/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

enum GitStatus {

    case unmodified
    case ignored

    case addedInIndex
    case deletedInIndex
    case modifiedInIndex
    case renamedInIndex

    case addedInWorktree
    case deletedInWorktree
    case modifiedInWorktree
    case renamedInWorktree
    
}
