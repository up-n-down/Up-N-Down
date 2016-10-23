//
//  ViewController.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    // MARK: Actions

    @IBAction func openPreferencesDidPress(_ sender: NSButton) {
        let extensionsPreferences = URL(fileURLWithPath: "/System/Library/PreferencePanes/Extensions.prefPane")
        NSWorkspace.shared().open(extensionsPreferences)
    }

}

