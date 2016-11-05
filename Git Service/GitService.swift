//
//  Git.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 01/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation
import ObjectiveGit

enum GitError: Error {

    case invalidPath

}

class GitService : NSObject, GitServiceProtocol {

    private let queue = DispatchQueue(label: "io.up-n-down.up-n-down-git-service")

    func createRepository(at url: URL, errorHandler: @escaping GitServiceProtocol.ErrorHandler) {
        queue.async {
            do {
                _ = try GTRepository.initializeEmpty(atFileURL: url, options: nil)
                errorHandler(nil)
            } catch let error {
                errorHandler(error)
            }
        }
    }

    func cloneRepository(from origin: String, to directory: URL, errorHandler: @escaping GitServiceProtocol.ErrorHandler) {
        queue.async {
            guard let originURL = URL(string: origin) else {
                errorHandler(GitError.invalidPath)
                return
            }

            do {
                try GTRepository.clone(from: originURL,
                                       toWorkingDirectory: directory,
                                       options: nil,
                                       transferProgressBlock: nil,
                                       checkoutProgressBlock: nil)
            } catch let error {
                errorHandler(error)
            }
            
            errorHandler(nil)
        }
    }
    
}
