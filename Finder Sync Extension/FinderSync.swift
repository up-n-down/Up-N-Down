//
//  FinderSync.swift
//  Finder Sync Extension
//
//  Created by Thomas Paul Mann on 21/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import FinderSync

class FinderSync: FIFinderSync {

    // MARK: - Properties

    let finderSyncController = FIFinderSyncController.default()
    let git = GitClient()

    // MARK: - Intialiser

    override init() {
        super.init()

        // Set up the directory we are syncing.
        let directoryURL = URL(fileURLWithPath: "/")
        finderSyncController.directoryURLs = [directoryURL]
        
        // Set up images for our badge identifiers.
        Badge.all.forEach { finderSyncController.register($0) }

//        let launchPath = "/usr/bin/osascript"
//        let command = "display notification \"Hello\" with title \"Up-N-Down\" subtitle \"Finder Sync Extension\""
//        let arguments = [
//            "-e",
//            command
//        ]
//
//        Process.launchedProcess(launchPath: launchPath, arguments: arguments)
    }

}

extension FinderSync: NSUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

}
