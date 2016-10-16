//
//  URL.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
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
    func recursive(block: ((URL) -> (Bool))) {
        var recursiveURL = self

        for _ in self.pathComponents {
            if !block(recursiveURL) {
                recursiveURL = recursiveURL.deletingLastPathComponent()
            } else {
                return
            }
        }
    }

}
