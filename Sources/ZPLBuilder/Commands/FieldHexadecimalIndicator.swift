//
//  FieldHexadecimalIndicator.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^FH command allows you to enter the hexadecimal value for any character directly into the ^FD statement. 
/// The ^FH command must precede each ^FD command that uses hexadecimals in its field.
///
/// **Field Hexadecimal Indicator**
///
/// Within the ^FD statement, the hexadecimal indicator must precede each hexadecimal value. 
/// The default hexadecimal indicator is _ (underscore).
/// There must be a minimum of two characters designated to follow the underscore.
/// The a parameter can be added when a different hexadecimal indicator is needed.
///
/// This command can be used with any of the commands that have field data (that is ^FD, ^FV (Field Variable), and ^SN (Serialized Data)).
///
/// Valid hexadecimal characters are:
/// 0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f
public struct FieldHexadecimalIndicator: ZPLCommandConvertible {
    public var indicator: Character
    public var command: String {
        "^FH\(indicator)"
    }
    
    public init(indicator: Character = "_") {
        self.indicator = indicator
    }
}
