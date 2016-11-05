//
//  NSAlert+Show.swift
//  up-n-down
//
//  Created by Thomas Paul Mann on 03/09/16.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation
import Cocoa

extension NSAlert {

    typealias CompletionHandler = ((NSModalResponse, NSTextField?) -> (Void))

    static func show(with title: String,
                          message: String,
                          actionButtonTitle: String,
                          inputTextFieldPlaceholder: String? = nil,
                          completionHandler: CompletionHandler) {
        let alert = NSAlert()
        alert.window.title = title
        alert.messageText = message
        alert.addButton(withTitle: actionButtonTitle)
        alert.addButton(withTitle: "Cancel")

        var textField: NSTextField?
        if let placeholder = inputTextFieldPlaceholder {
            textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
            textField!.usesSingleLineMode = true
            textField!.lineBreakMode = .byTruncatingTail
            textField!.maximumNumberOfLines = 1
            textField!.placeholderString = placeholder
            alert.accessoryView = textField
        }

//        NSApplication.shared().activate(ignoringOtherApps: true)

        NSLog("Show alert with title \(title)")

        let modalResponse = alert.runModal()

        NSLog("Alert did run modal.")

        completionHandler(modalResponse, textField)
    }

    static func show(_ error: Error) {
        let alert = NSAlert()
        alert.window.title = "Ups, something went wrong..."
        alert.messageText = error.localizedDescription
        alert.addButton(withTitle: "OK")

        NSApplication.shared().activate(ignoringOtherApps: true)

        _ = alert.runModal()
    }

}
