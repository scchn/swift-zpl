//
//  FieldHexadecimal.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

public struct FieldHexadecimal: ZPLCommandConvertible {
    public var indicator: Character
    public var code: UInt8
    public var command: String {
        String(format: "%02X", code)
    }
    
    public init(indicator: Character = "_", code: UInt8) {
        self.indicator = indicator
        self.code = code
    }
}
