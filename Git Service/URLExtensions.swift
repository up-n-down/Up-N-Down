//
//  URLExtensions.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 22/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation

extension URL {

    /// Returns a relative path to the base URL.
    func relativePath(for baseURL: URL) -> String? {
        // Make sure to return a relative path.
        if baseURL.path.characters.last != "/" {
            return path.replacingOccurrences(of: baseURL.path + "/", with: "")
        } else {
            return path.replacingOccurrences(of: baseURL.path, with: "")
        }
    }

    /// Go recursive through URL (bottom up) and execute block.
    func recursive(_ block: @escaping ((URL) -> (Bool))) {
        var recursiveURL = self

        self.pathComponents.forEach { _ in
            if !block(recursiveURL) {
                recursiveURL = recursiveURL.deletingLastPathComponent()
            } else {
                return
            }
        }
    }

}
