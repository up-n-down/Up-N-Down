//
//  FIFinderSyncController.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import FinderSync

extension FIFinderSyncController {

    /// Register the badge for further usage.
    func register(_ badge: Badge) {
        self.setBadgeImage(badge.image, label: badge.identifier, forBadgeIdentifier: badge.identifier)
    }

    var selectedItemsRepresentation: String {
        var selectedItems = ""

        if let selectedItemURLs = self.selectedItemURLs() {
            if selectedItemURLs.count == 1 {
                selectedItems = "”\(selectedItemURLs[0].lastPathComponent)”"
            } else {
                selectedItems.append("\(selectedItemURLs.count) Items")
            }
        }

        return selectedItems
    }

}
