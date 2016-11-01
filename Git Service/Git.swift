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

    func createRepository(at url: URL, completionHandler: ((Error?) -> (Void))) {
        do {
            _ = try GTRepository.initializeEmpty(atFileURL: url, options: nil)
            completionHandler(nil)
        } catch let error {
            completionHandler(error)
        }
    }

}
