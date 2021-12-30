//
//  MIDIChannelPrefix.swift
//  Swimi
//
//  Created by Kainosuke OBATA on 2020/08/16.
//

import Foundation

public struct MIDIPortPrefix: MetaEventParsing, Equatable {
    
    
    public static func parse<SSType: SequencerSpecific>(
        _ smfBytes: ArraySlice<UInt8>
    ) -> ParseResult<MetaEvent<SSType>> {
        guard smfBytes.prefix(prefix.count) == prefix[...] else {
            return .failure(.length(0))
        }
        
        let bytes = smfBytes.dropFirst(prefix.count)
        guard let value = Int.fromBytes(bytes, length: 1) else {
            return .failure(.length(smfBytes.count))
        }
        
        return .success(
            ParseSucceeded(
                length: length,
                component: .midiPortPrefix(port: value)
            )
        )
    }
    
    public var smfBytes: [UInt8] {
        Self.prefix + port.toBytes(length: 1)
    }
    
    /// MIDI channel: 0 ~ 15
    public var port: Int
    
    public init(port: Int) {
        self.port = port
    }
    
    private static let prefix: [UInt8] = [0xFF, 0x21, 0x01]
    private static let length: Int = prefix.count + 1
}
