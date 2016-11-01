//
//  GitServiceProtocol.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 01/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation

@objc(GitServiceProtocol)
protocol GitServiceProtocol {

    func createRepository(at url: URL, errorHandler: ((Error) -> (Void)))

}
