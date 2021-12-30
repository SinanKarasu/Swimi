//
//  MetaEvent.swift
//  Swimi
//
//  Created by Kainosuke OBATA on 2020/08/04.
//

import Foundation

public enum MetaEvent<SSType: SequencerSpecific>: Equatable {
    case sequenceNumber(SequenceNumber)
    case text(TextEvent)
    case copyright(Copyright)
    case trackName(TrackNameEvent)
    case instrumentName(InstrumentNameEvent)
    case lyric(Lyric)
    case marker(Marker)
    case cuePoint(CuePoint)
    case midiChannelPrefix(MIDIChannelPrefix)
    case midiPortPrefix(MIDIPortPrefix)
    case endOfTrack(EndOfTrack)
    case setTempo(SetTempo)
    case smpteOffset(SMPTEOffsetEvent)
    case timeSignature(TimeSignature)
    case keySignature(KeySignature)
    case sequencerSpecific(SSType)
    
    case unknown(UnknownMetaEvent)
    
    public var smfBytes: [UInt8] {
        switch self {
        case .sequenceNumber    (let e): return e.smfBytes
        case .text              (let e): return e.smfBytes
        case .copyright         (let e): return e.smfBytes
        case .trackName         (let e): return e.smfBytes
        case .instrumentName    (let e): return e.smfBytes
        case .lyric             (let e): return e.smfBytes
        case .marker            (let e): return e.smfBytes
        case .cuePoint          (let e): return e.smfBytes
        case .midiChannelPrefix (let e): return e.smfBytes
        case .midiPortPrefix    (let e): return e.smfBytes
        case .endOfTrack        (let e): return e.smfBytes
        case .setTempo          (let e): return e.smfBytes
        case .smpteOffset       (let e): return e.smfBytes
        case .timeSignature     (let e): return e.smfBytes
        case .keySignature      (let e): return e.smfBytes
        case .sequencerSpecific (let e): return e.smfBytes
        case .unknown           (let e): return e.smfBytes
        }
    }
    
    /// Convenience methods
    public var timeSignatureOrNil: TimeSignature? {
        switch self {
        case .timeSignature(let e): return e
        default: return nil
        }
    }
}

//MARK: - Extensions for convenience
public extension MetaEvent {
    static func sequenceNumber(_ value: Int) -> MetaEvent {
        return .sequenceNumber(SequenceNumber(value))
    }
    
    static func text(_ data: [UInt8]) -> MetaEvent {
        return .text(TextEvent(data: data))
    }

    static func copyright(_ data: [UInt8]) -> MetaEvent {
        return .copyright(Copyright(data: data))
    }

    static func trackName(_ data: [UInt8]) -> MetaEvent {
        return .trackName(TrackNameEvent(data: data))
    }

    static func instrumentName(_ data: [UInt8]) -> MetaEvent {
        return .instrumentName(InstrumentNameEvent(data: data))
    }

    static func lyric(_ data: [UInt8]) -> MetaEvent {
        return .lyric(Lyric(data: data))
    }

    static func marker(_ data: [UInt8]) -> MetaEvent {
        return .marker(Marker(data: data))
    }

    static func cuePoint(_ data: [UInt8]) -> MetaEvent {
        return .cuePoint(CuePoint(data: data))
    }
    
    static func midiChannelPrefix(channel: Int) -> MetaEvent {
        return .midiChannelPrefix(MIDIChannelPrefix(channel: channel))
    }

    static func midiPortPrefix(port: Int) -> MetaEvent {
        return .midiPortPrefix(MIDIPortPrefix(port: port))
    }

    static func endOfTrack() -> MetaEvent {
        return .endOfTrack(EndOfTrack())
    }
    
    static func setTempo(bpm: Double) -> MetaEvent {
        return .setTempo(SetTempo(bpm: bpm))
    }

    static func smpteOffset(_ data: [UInt8]) -> MetaEvent {
        return .smpteOffset(SMPTEOffsetEvent(data))
    }

    static func setTempo(microsecondsPerQuarterNote: Int) -> MetaEvent {
        return .setTempo(SetTempo(microsecondsPerQuarterNote: microsecondsPerQuarterNote))
    }
    
    static func timeSignature(
        numerator: Int,
        denominator: Int,
        midiClocksPerMetronomeClick: Int,
        thirtySecondNotesPer24MIDIClocks: Int
    ) -> MetaEvent {
        return .timeSignature(
            TimeSignature(
                numerator: numerator,
                denominator: denominator,
                midiClocksPerMetronomeClick: midiClocksPerMetronomeClick,
                thirtySecondNotesPer24MIDIClocks: thirtySecondNotesPer24MIDIClocks)
        )
    }
    
    static func timeSignature(
        numerator: Int,
        denominatorPowerOfTwo: Int,
        midiClocksPerMetronomeClick: Int,
        thirtySecondNotesPer24MIDIClocks: Int
    ) -> MetaEvent {
        return .timeSignature(
            TimeSignature(
                numerator: numerator,
                denominatorPowerOfTwo: denominatorPowerOfTwo,
                midiClocksPerMetronomeClick: midiClocksPerMetronomeClick,
                thirtySecondNotesPer24MIDIClocks: thirtySecondNotesPer24MIDIClocks
            )
        )
    }
    
    static func keySignature(
        numberOfSharpsOrFlats: Int,
        mode: KeySignature.Mode
    ) -> MetaEvent {
        return .keySignature(
            KeySignature(
                numberOfSharpsOrFlats: numberOfSharpsOrFlats,
                mode: mode
            )
        )
    }
    
    static func unknown(_ smfBytes: [UInt8]) -> MetaEvent {
        return .unknown(UnknownMetaEvent(smfBytes: smfBytes))
    }
}
