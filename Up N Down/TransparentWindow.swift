//
//  ModernWindow.swift
//  up-n-down
//
//  Created by Thomas Paul Mann on 31/05/16.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Cocoa

class TransparentWindow: NSWindow {
    override init(contentRect: NSRect, styleMask aStyle: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: aStyle, backing: bufferingType, defer: flag)

        titlebarAppearsTransparent = true
        isMovableByWindowBackground = true
    }

}
