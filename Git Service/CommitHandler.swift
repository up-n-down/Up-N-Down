//
//  CommitHandler.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 05/12/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import Foundation
import ObjectiveGit

struct CommitHandler {

    // MARK: - Properties

    let repository: GTRepository

    // MARK: - API

    func commit(message: String) throws {
        do {
            let head  = try repository.headReference()
            let index = try repository.index()
            let tree  = try index.writeTree()

            guard
                let parentCommit = parentCommit,
                let signature = GTSignature(name: "Thomas Paul Mann", email: "hi@thomaspaulmann.com", time: Date())
            else {
                return
            }

            try repository.createCommit(with: tree,
                                        message: message,
                                        author: signature,
                                        committer: signature,
                                        parents: [parentCommit],
                                        updatingReferenceNamed: head.name)

        }
    }

    /// Returns the parent commit for the current head reference.
    private var parentCommit: GTCommit? {
        do {
            let enumerator = try GTEnumerator(repository: repository)
            let head = try repository.headReference()

            try enumerator.pushSHA(head.targetOID.sha)

            return enumerator.nextObject() as? GTCommit
        } catch _ {
            return nil
        }
    }
    
    
}
