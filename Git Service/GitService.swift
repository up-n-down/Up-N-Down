//
//  Service.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation
import ObjectiveGit

enum GitServiceError: Error {

    case invalidFileURL

}

/// Represents the service.
class GitService: GitServiceProtocol {

    // MARK: - Initialiser

    func createRepository(at url: URL, onFailure errorHandler: ((Error) -> Void)? = nil) {
        do {
            _ = try GTRepository.initializeEmpty(at: url)
        } catch let error {
            errorHandler?(error)
        }
    }

    func cloneRepository(from origin: URL, to destination: URL, onFailure errorHandler: ((Error) -> Void)? = nil) {
        do {
            _ = try GTRepository.clone(from: origin, to: destination)
        } catch let error {
            errorHandler?(error)
        }
    }

    // MARK: - Status

    func status(for fileURL: URL, onCompletion completionHandler: @escaping (GitStatus, Error?) -> Void) {
        do {
            let repositoryManager = RepositoryHandler()
            guard let repository = repositoryManager.repository(for: fileURL) else {
                // TODO: Throw error to handle this behaviour in client
                completionHandler(.unmodified, nil)
                return
            }

            let statusHandler = StatusHandler(repository: repository)
            let status = try statusHandler.status(for: fileURL)

            completionHandler(status ?? .unmodified, nil)
        } catch let error {
            completionHandler(.unmodified, error)
        }
    }

    // MARK: - Commit

    public func commit(_ message: String, inRepository repositoryURL: URL, onCompletion completionHandler: ((Error?) -> Void)? = nil) {
        do {
            let repositoryManager = RepositoryHandler()
            guard let repository = repositoryManager.repository(for: repositoryURL) else {
                completionHandler?(GitServiceError.invalidFileURL)
                return
            }

            let commitHandler = CommitHandler(repository: repository)
            try commitHandler.commit(message: message)
            completionHandler?(nil)
        } catch let error {
            completionHandler?(error)
        }

    }

    // MARK: - Index

    func add(toIndex fileURL: URL, onCompletion completionHandler: ((Error?) -> Void)? = nil) {
        do {
            let repositoryManager = RepositoryHandler()
            guard let repository = repositoryManager.repository(for: fileURL) else {
                completionHandler?(GitServiceError.invalidFileURL)
                return
            }

            let indexHandler = IndexHandler(repository: repository)
            try indexHandler.add(toIndex: fileURL)
            completionHandler?(nil)
        } catch let error {
            completionHandler?(error)
        }
    }

    public func remove(fromIndex fileURL: URL, onCompletion completionHandler: ((Error?) -> Void)? = nil) {
        do {
            let repositoryManager = RepositoryHandler()
            guard let repository = repositoryManager.repository(for: fileURL) else {
                completionHandler?(GitServiceError.invalidFileURL)
                return
            }

            let indexHandler = IndexHandler(repository: repository)
            try indexHandler.remove(fromIndex: fileURL)
            completionHandler?(nil)
        } catch let error {
            completionHandler?(error)
        }
    }


}
