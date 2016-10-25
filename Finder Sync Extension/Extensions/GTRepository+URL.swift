//
//  GTRepository.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation
import ObjectiveGit

extension GTRepository {

    /// Returns the root of the repository.
    var URL: URL? {
        return self.gitDirectoryURL?.deletingLastPathComponent()
    }

}
