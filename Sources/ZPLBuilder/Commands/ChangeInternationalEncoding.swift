//
//  ChangeInternationalEncoding.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^CI command enables you to call up the international character set you want to use for printing. You can mix character sets on a label.
///
/// **Change International Font/Encoding**
///
/// Zebra printers can print fonts using international character sets: U.S.A.1, U.S.A.2, UK, Holland, Denmark/ Norway, Sweden/Finland, Germany, France 1, France 2, Italy, Spain, and several other sets, including the Unicode character set.
///
/// A character within a font can be remapped to a different numerical position.
///
/// In x.14 version of firmware and later, this command allows character remapping when parameter a = 0-13.
public struct ChangeInternationalEncoding: ZPLCommandConvertible {
    /// Desired character set
    public var characterSet: UInt8
    public var remapping: [(source: UInt8, destination: UInt8)]
    public var command: String {
        "^CI\(characterSet)" + 
        remapping.map { ",\($0),\($1)" }.joined()
    }
    
    /// Change International Font/Encoding
    ///
    /// - Parameters:
    ///   - characterSet: Desired character set
    ///   - remapping: Remapping sources and destinations.
    public init(characterSet: UInt8, remapping: (source: UInt8, destination: UInt8)...) {
        self.characterSet = characterSet
        self.remapping = remapping
    }
}
