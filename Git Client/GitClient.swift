//
//  GitClient.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 21/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation

enum GitClientError: Error {

    case invalidProxyObject

}

/// This is the object that you should use on your app site to communicate with the background XPC service.
class GitClient {

    // MARK: - Properties

    fileprivate let xpcConnection: NSXPCConnection

    private let serviceName = "io.up-n-down.Up-N-Down.Git-Service"
    private let invalidationHandler = { NSLog("🔥 Git Service was invalidated.") }
    private let interruptionHandler = { NSLog("⚡️ Git Service was interrupted.") }

    // MARK: - Lifecycle

    init() {
        xpcConnection = NSXPCConnection(serviceName: serviceName)
        xpcConnection.invalidationHandler = invalidationHandler
        xpcConnection.interruptionHandler = interruptionHandler
        xpcConnection.remoteObjectInterface = NSXPCInterface(with: GitServiceProtocol.self)
        xpcConnection.resume()
    }

    deinit {
        xpcConnection.invalidate()
    }

}

// MARK: - Git Service

extension GitClient: GitServiceProtocol {

    /// Returns interface to the `Git Service Protocol` if valid.
    private var interface: GitServiceProtocol? {
        return xpcConnection.remoteObjectProxyWithErrorHandler({ error in
            NSLog(error.localizedDescription)
        }) as? GitServiceProtocol
    }

    // MARK: - Initialiser

    func createRepository(at url: URL, onFailure errorHandler: ((Error) -> Void)? = nil) {
        guard let interface = interface else {
            errorHandler?(GitClientError.invalidProxyObject)
            return
        }

        interface.createRepository(at: url, onFailure: errorHandler)
    }

    func cloneRepository(from origin: URL, to destination: URL, onFailure errorHandler: ((Error) -> Void)? = nil) {
        guard let interface = interface else {
            errorHandler?(GitClientError.invalidProxyObject)
            return
        }

        interface.cloneRepository(from: origin, to: destination, onFailure: errorHandler)
    }

    // MARK: - Status

    func status(for fileURL: URL, onCompletion completionHandler: @escaping (GitStatus, Error?) -> Void) {
        guard let interface = interface else {
            completionHandler(.unmodified, GitClientError.invalidProxyObject)
            return
        }

        interface.status(for: fileURL, onCompletion: completionHandler)
    }

    // MARK: - Index

    func add(toIndex fileURL: URL, onCompletion completionHandler: ((Error?) -> Void)? = nil) {
        guard let interface = interface else {
            completionHandler?(GitClientError.invalidProxyObject)
            return
        }

        interface.add(toIndex: fileURL, onCompletion: completionHandler)
    }

    public func remove(fromIndex fileURL: URL, onCompletion completionHandler: ((Error?) -> Void)? = nil) {
        guard let interface = interface else {
            completionHandler?(GitClientError.invalidProxyObject)
            return
        }

        interface.remove(fromIndex: fileURL, onCompletion: completionHandler)
    }

    public func commit(_ message: String, inRepository repositoryURL: URL, onCompletion completionHandler: ((Error?) -> Void)? = nil) {
        guard let interface = interface else {
            completionHandler?(GitClientError.invalidProxyObject)
            return
        }

        interface.commit(message, inRepository: repositoryURL, onCompletion: completionHandler)
    }


}
