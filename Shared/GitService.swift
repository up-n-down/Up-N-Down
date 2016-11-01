//
//  GitService.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 01/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation

class GitService {

    private static let name = "io.up-n-down.up-n-down-git-service"

    private let errorHandler: GitServiceProtocol.ErrorHandler = { error in
        print("remote proxy error: \(error)")
    }

    private lazy var serviceConnection: NSXPCConnection = {
        let connection = NSXPCConnection(serviceName: GitService.name)
        connection.remoteObjectInterface = NSXPCInterface(with: GitServiceProtocol.self)
        connection.resume()
        return connection
    }()

    deinit {
        serviceConnection.invalidate()
    }

    func createRepository(at url: URL) {
        guard let git = serviceConnection.remoteObjectProxyWithErrorHandler(errorHandler) as? GitServiceProtocol else {
            return
        }

        git.createRepository(at: url, errorHandler: errorHandler)
    }

}
