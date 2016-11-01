//
//  Git.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 01/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation
import ObjectiveGit

class Git : NSObject, GitServiceProtocol {

    func createRepository(at url: URL, errorHandler: GitServiceProtocol.ErrorHandler) {
        do {
            let repository = try GTRepository.initializeEmpty(atFileURL: url, options: nil)
            NSLog("Created repository \(repository) at \(url).")
        } catch let error {
            NSLog("Error during creating repository: \(error)")
            errorHandler(error)
        }
    }

}
