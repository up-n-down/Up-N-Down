//
//  Repository.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 16/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation
import ObjectiveGit

struct Repository {

    let repository: GTRepository

    init?(from url: URL) {
        do {
            self.repository = try GTRepository(url: url)

            NSLog("Open repository @ \(url)")
        } catch _ {
            NSLog("Unable to open repository @ \(url)")
            return nil
        }
    }
    
}

