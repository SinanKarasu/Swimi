//
//  TimingClock.swift
//  Swimi
//
//  Created by kai on 2019/10/05.
//  Copyright © 2019 kai. All rights reserved.
//

import Foundation

public struct TimingClock: Equatable {
    
    static func fromData(_ data: [UInt8]) -> TimingClock {
        assert(data.count == 1)
        return TimingClock()
    }
}
