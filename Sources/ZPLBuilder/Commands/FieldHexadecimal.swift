//
//  FieldHexadecimal.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

public struct FieldHexadecimal: ZPLCommandConvertible {
    /// Hexadecimal indicator
    ///
    /// Values: any character except current format and control prefix (^ and ~ by default)
    ///
    /// Default: _ (underscore)
    public var indicator: Character
    /// Special character's hexadecimal value.
    public var code: UInt8
    public var command: String {
        String(format: "\(indicator)%02X", code)
    }
    
    /// Field Hexadecimal
    ///
    /// - Parameters:
    ///   - indicator: Hexadecimal indicator. Values: any character except current format and control prefix (^ and ~ by default).
    ///   - code: Special character's hexadecimal value.
    public init(indicator: Character = "_", code: UInt8) {
        self.indicator = indicator
        self.code = code
    }
}
