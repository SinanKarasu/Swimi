//
//  SMPTEOffsetEvent.swift
//  Swimi
//
//  Created by Kainosuke OBATA on 2020/08/04.
//

import Foundation

public struct SMPTEOffsetEvent: MetaEventParsing, Equatable {
    
    public static func parse<SSType: SequencerSpecific>(_ smfBytes: ArraySlice<UInt8>) -> ParseResult<MetaEvent<SSType>> {
        guard smfBytes.prefix(prefix.count) == prefix[...] else {
            return .failure(.length(0))
        }
         let value = smfBytes.dropFirst(prefix.count)
//        guard let value = Int.fromBytes(bytes, length: 5) else {
//            return .failure(.length(smfBytes.count))
//        }

        return .success(
            ParseSucceeded(
                length: prefix.count + 5,
                component: .smpteOffset(Array(value))
            )
        )
    }
    
    public var smfBytes: [UInt8] {
        return Self.prefix + data
    }
    
    public var data: [UInt8]

    public var hr: UInt8 {
        return data[0]
    }

    public var mn: UInt8 {
        return data[1]
    }
    public var se: UInt8 {
        return data[2]
    }
    public var fr: UInt8 {
        return data[3]
    }
    public var ff: UInt8 {
        return data[4]
    }

    public init(_ data: [UInt8]) {
        guard data.count == 5 else {
            fatalError("SMPTEOffset Number must be 5 bytes.")
        }
        self.data = data
    }
    
    private static let prefix: [UInt8] = [0xFF, 0x54, 0x05]
}
