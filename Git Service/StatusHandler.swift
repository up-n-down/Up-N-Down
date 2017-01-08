//
//  StatusManager.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation
import ObjectiveGit

struct StatusHandler {

    // MARK: - Properties

    let repository: GTRepository

    // MARK: - API

    func status(for fileURL: URL) throws -> GitStatus? {
        // Build relative path of file URL.
        guard let filePath = fileURL.relativePath(for: repository.fileURL) else {
            throw GitServiceError.invalidFileURL
        }

        // Retrieve status of file.
        var error: NSError?
        let fileStatusFlags = repository.status(forFile: filePath, success: nil, error: &error)
        guard error == nil else {
            throw error!
        }

        // Report status.
        return GitStatus(from: fileStatusFlags)
    }

}
