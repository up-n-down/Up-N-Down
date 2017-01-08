//
//  main.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation

//let launchPath = "/usr/bin/osascript"
//let command = "display notification \"Hello\" with title \"Up-N-Down\" subtitle \"Finder Sync Extension\""
//let arguments = [
//    "-e",
//    command
//]
//
//Process.launchedProcess(launchPath: launchPath, arguments: arguments)

let delegate = GitServiceDelegate()

let service = NSXPCListener.service()
service.delegate = delegate
service.resume()
