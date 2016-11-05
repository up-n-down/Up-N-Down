//
//  ErrorHandler.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 05/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation
import AppKit

let errorHandler: GitServiceProtocol.ErrorHandler = { error in
    // If there is no error, do nothing.
    guard let error = error else {
        return
    }

    DispatchQueue.main.async {
        NSAlert.show(error)
    }
}
