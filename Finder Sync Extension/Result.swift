//
//  Result.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 01/11/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Foundation

enum Result<Value> {

    case success(Value)
    case failure(Error)
    
}
