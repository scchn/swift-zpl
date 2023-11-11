//
//  Hyphen.swift
//  
//
//  Created by chen on 2023/11/11.
//

import Foundation

public enum Hyphen: ZPLCommandConvertible {
    /// \&. Carriage return/line feed
    case `return`
    /// \(*). Soft hyphen (word break with a dash)
    case softHyphen(Character)
    /// \\. = backslash (\)
    ///
    /// ^CI13 must be selected to print a backslash (\).
    case backslash
    
    public var command: String {
        switch self {
        case .return:            return #"\&"#
        case .softHyphen(let c): return #"\\#(c)"#
        case .backslash:         return #"\\"#
        }
    }
}
