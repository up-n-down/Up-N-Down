//
//  main.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 01/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation

class GitServiceDelegate : NSObject, NSXPCListenerDelegate {

    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: GitServiceProtocol.self)
        let exportedObject = Git()
        newConnection.exportedObject = exportedObject
        newConnection.resume()
        return true
    }

}


// Create the listener and resume it:
let delegate = GitServiceDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate
listener.resume()
