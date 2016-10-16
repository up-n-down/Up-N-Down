//
//  Repository+Status.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation
import ObjectiveGit

extension Repository {

    /// Returns the file status flags for the file at the path.
    private func statusFlags(for file: URL) -> GTFileStatusFlags? {
        guard
            let repoURL = repository.URL,
            let filePath = file.relativePath(for: repoURL)
        else {
            return nil
        }

        var error: NSError?

        let fileStatusFlags = repository.status(forFile: filePath, success: nil, error: &error)

        // If there is an error, do nothing.
        guard error == nil else {
            NSLog("\(error)")
            return nil
        }

        return fileStatusFlags
    }

    /// Returns the Git status for the file at the path.
    func status(for file: URL) -> GitStatus? {
        if let fileStatusFlags = statusFlags(for: file) {
            return GitStatus(from: fileStatusFlags)
        }
        
        return nil
    }

}
