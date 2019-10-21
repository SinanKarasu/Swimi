//
//  Continue.swift
//  Swimi
//
//  Created by kai on 2019/10/06.
//  Copyright © 2019 kai. All rights reserved.
//

import Foundation

public struct Continue: Equatable {
    
    static func fromData(_ data: [UInt8]) -> Continue {
        assert(data.count == 1)
        return Continue()
    }
}
