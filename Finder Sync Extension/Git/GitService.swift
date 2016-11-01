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

    private let errorHandler: ((Error) -> (Void)) = { error in
        NSLog("Remote proxy error: \(error)")
    }

    private lazy var serviceConnection: NSXPCConnection = {
        let connection = NSXPCConnection(serviceName: GitService.name)
        connection.remoteObjectInterface = NSXPCInterface(with: GitServiceProtocol.self)
        connection.resume()

        return connection
    }()

    private lazy var git: GitServiceProtocol = {
        return self.serviceConnection.remoteObjectProxyWithErrorHandler(self.errorHandler) as! GitServiceProtocol
    }()

    // MARK: - Lifecycle

    deinit {
        serviceConnection.invalidate()
    }

    // MARK: - Public API

    func createRepository(at url: URL, completionHandler: @escaping ((Result<Void>) -> (Void))) {
        git.createRepository(at: url) { error in
            DispatchQueue.main.async {
                if error == nil {
                    NSLog("Created repository at \(url)")
                    completionHandler(.success())
                } else {
                    NSLog("Error during creating repository: \(error)")
                    completionHandler(.failure(error!))
                }
            }
        }
    }

}
