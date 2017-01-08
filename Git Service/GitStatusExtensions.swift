//
//  GitStatusExtensions.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation
import ObjectiveGit

// MARK: - File Status Flags

extension GitStatus {

    init(from flags: GTFileStatusFlags) {
        if flags.contains(GTFileStatusFlags.ignored) {
            self = .ignored
        } else if flags.contains(GTFileStatusFlags.newInIndex) {
            self = .addedInIndex
        } else if flags.contains(GTFileStatusFlags.newInWorktree) {
            self = .addedInWorktree
        } else if flags.contains(GTFileStatusFlags.deletedInIndex) {
            self = .deletedInIndex
        } else if flags.contains(GTFileStatusFlags.deletedInWorktree) {
            self = .deletedInWorktree
        } else if flags.contains(GTFileStatusFlags.modifiedInIndex) {
            self = .modifiedInIndex
        } else if flags.contains(GTFileStatusFlags.modifiedInWorktree) {
            self = .modifiedInWorktree
        } else if flags.contains(GTFileStatusFlags.renamedInIndex) || flags.contains(GTFileStatusFlags.typeChangedInIndex) {
            self = .renamedInIndex
        } else if flags.contains(GTFileStatusFlags.renamedInWorktree) || flags.contains(GTFileStatusFlags.typeChangedInWorktree) {
            self = .renamedInWorktree
        } else {
            self = .unmodified
        }
    }

}
