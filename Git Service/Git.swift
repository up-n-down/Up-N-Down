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

    private let queue = DispatchQueue(label: "io.up-n-down.up-n-down-git-service")

    func createRepository(at url: URL, completionHandler: @escaping ((Error?) -> (Void))) {
        queue.async {
            do {
                _ = try GTRepository.initializeEmpty(atFileURL: url, options: nil)
                completionHandler(nil)
            } catch let error {
                completionHandler(error)
            }
        }
    }

}
