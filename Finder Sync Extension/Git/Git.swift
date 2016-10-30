//
//  Repository.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation
import ObjectiveGit

class Git {

    // MARK: - Properties

    var repository: GTRepository?

    // MARK: - Repository

    func openRepository(at url: URL) throws {
        self.repository = try GTRepository(url: url)
    }

    func createRepository(at url: URL) throws {
        repository = try GTRepository.initializeEmpty(atFileURL: url, options: nil)
    }

}

