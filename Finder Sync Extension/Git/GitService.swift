//
//  GitService.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 01/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation

class GitService {

    // MARK: - Properties

    private static let name = "io.up-n-down.up-n-down-git-service"

    private lazy var serviceConnection: NSXPCConnection = {
        let connection = NSXPCConnection(serviceName: GitService.name)
        connection.remoteObjectInterface = NSXPCInterface(with: GitServiceProtocol.self)
        connection.resume()

        return connection
    }()

    private lazy var git: GitServiceProtocol = {
        let errorHandler: ((Error) -> (Void)) = { NSLog("Remote proxy error: \($0)") }

        return self.serviceConnection.remoteObjectProxyWithErrorHandler(errorHandler) as! GitServiceProtocol
    }()

    // MARK: - Lifecycle

    deinit {
        serviceConnection.invalidate()
    }

    // MARK: - Public API

    func createRepository(at url: URL, errorHandler: @escaping GitServiceProtocol.ErrorHandler) {
        git.createRepository(at: url, errorHandler:  errorHandler)
    }

    func cloneRepository(from origin: String, to directory: URL, errorHandler: @escaping GitServiceProtocol.ErrorHandler) {
        git.cloneRepository(from: origin, to: directory, errorHandler: errorHandler)
    }

}
