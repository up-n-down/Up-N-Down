//
//  ObjectiveGitExtensions.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation
import ObjectiveGit

extension GTRepository {

    static func initializeEmpty(at source: URL) throws -> GTRepository {
        return try GTRepository.initializeEmpty(atFileURL: source,
                                                options: nil)
    }

    static func clone(from source: URL, to workingDirectory: URL) throws -> GTRepository {
        return try GTRepository.clone(from: source,
                                      toWorkingDirectory: workingDirectory,
                                      options: nil,
                                      transferProgressBlock: nil,
                                      checkoutProgressBlock: nil)
    }
    
}
