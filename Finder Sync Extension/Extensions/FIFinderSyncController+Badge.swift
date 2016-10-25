//
//  FIFinderSyncController+Badge.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import FinderSync

extension FIFinderSyncController {

    /// Register the badge for further usage.
    func register(badge: Badge) {
        self.setBadgeImage(badge.image, label: badge.identifier, forBadgeIdentifier: badge.identifier)
    }

}
