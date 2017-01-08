//
//  NSMenuItem.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 30/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Cocoa

extension NSMenuItem {

    /// Convenience initialiser for menu item.
    public convenience init(title: String, action: Selector? = nil) {
        self.init(title: title, action: action ?? nil, keyEquivalent: "")
    }
    
}
