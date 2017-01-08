//
//  FinderSync+Observation.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 21/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import FinderSync

extension FinderSync {

    override func beginObservingDirectory(at url: URL) {
        // The user is now seeing the container's contents.
        // If they see it in more than one view at a time, we're only told once.
        NSLog("beginObservingDirectoryAtURL: %@", url.path as NSString)
    }

    override func endObservingDirectory(at url: URL) {
        // The user is no longer seeing the container's contents.
        NSLog("endObservingDirectoryAtURL: %@", url.path as NSString)
    }

    override func requestBadgeIdentifier(for url: URL) {
        NSLog("requestBadgeIdentifierForURL: %@", url.path as NSString)

        git.status(for: url) { [weak self] status, error in
            if let error = error {
                NSAlert.runModal(withError: error)
            }

            self?.setBadgeIdentifier(for: status, forURL: url)
        }
    }

}

