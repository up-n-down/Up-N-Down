//
//  NSAlertExtensions.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Cocoa

extension NSAlert {

    /// Returns preconfigured alert.
    private static var preconfiguredAlert: NSAlert {
        let alert = NSAlert()
        alert.window.title = "Up-N-Down"
        alert.icon = NSImage(named: "App Icon")!

        return alert
    }

    typealias CompletionHandler = ((NSModalResponse, NSTextField) -> (Void))

    static func ask(for title: String,
                    message: String,
                    actionButtonTitle: String,
                    inputTextFieldPlaceholder: String,
                    completionHandler: @escaping CompletionHandler) {
        let alert = NSAlert()
        alert.window.title = title
        alert.messageText = message
        alert.addButton(withTitle: actionButtonTitle)
        alert.addButton(withTitle: "Cancel")

        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
        textField.usesSingleLineMode = true
        textField.lineBreakMode = .byTruncatingTail
        textField.maximumNumberOfLines = 1
        textField.placeholderString = inputTextFieldPlaceholder
        alert.accessoryView = textField

        DispatchQueue.main.async {
            let modalResponse = alert.runModal()
            completionHandler(modalResponse, textField)
        }
    }

    static func runModal(withInformation information: String) {
        let alert = preconfiguredAlert
        alert.alertStyle = .informational
        alert.informativeText = information

        DispatchQueue.main.async {
            alert.runModal()
        }
    }

    static func runModal(withError error: Error) {
        let alert = preconfiguredAlert
        alert.alertStyle = .critical
        alert.messageText = "Ups... Something went wrong?!"
        alert.informativeText = "Error: \(error)"

        DispatchQueue.main.async {
            alert.runModal()
        }
    }
    
}
