//
//  GitServiceProtocol.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 01/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation

@objc protocol GitServiceProtocol {

    typealias ErrorHandler = ((Error?) -> (Void))

    func createRepository(at url: URL, errorHandler: @escaping ErrorHandler)

    func cloneRepository(from origin: String, to directory: URL, errorHandler: @escaping ErrorHandler)

}
