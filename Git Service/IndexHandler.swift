//
//  IndexHandler.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 05/12/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation
import ObjectiveGit

struct IndexHandler {

    // MARK: - Properties

    let repository: GTRepository

    // MARK: - API

    func add(toIndex fileURL: URL) throws {
        let index = try repository.index()

        guard let filePath = fileURL.relativePath(for: repository.fileURL) else {
            throw GitServiceError.invalidFileURL
        }

        try index.addFile(filePath)
        try index.write()
    }

    func remove(fromIndex fileURL: URL) throws {
        let index = try repository.index()

        guard let filePath = fileURL.relativePath(for: repository.fileURL) else {
            throw GitServiceError.invalidFileURL
        }

        try index.removeFile(filePath) // Does not work 100%
        try index.write()
    }

}
