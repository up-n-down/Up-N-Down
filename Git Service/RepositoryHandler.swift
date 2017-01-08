//
//  RepositoryManager.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation
import ObjectiveGit

struct RepositoryHandler {

    func repository(for fileURL: URL) -> GTRepository? {
        // If it's a dictionary, do nothing.
        guard !fileURL.hasDirectoryPath else {
            // TODO: Handle directories in a custom way
            return nil
        }

        return findRepository(for: fileURL)
    }

    private func findRepository(for fileURL: URL) -> GTRepository? {
        var repository: GTRepository?

        // TODO: Refactor to do more like a search or filter
        fileURL.recursive { url in
            repository = try? GTRepository(url: url)
            return (repository != nil) // If no repository found, keep searching.
        }
        
        return repository
    }

}
