//
//  UIColor+Theme.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 26/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import AppKit

extension NSColor {

    static var primaryBlue: NSColor {
        let red = CGFloat(207.0 / 255.0)
        let green = CGFloat(221.0 / 255.0)
        let blue = CGFloat(241.0 / 255.0)

        return NSColor(calibratedRed: red, green: green, blue: blue, alpha: 1.0)
    }

}
