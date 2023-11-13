//
//  FieldParameter.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^FP command allows vertical and reverse formatting of the font field,
/// commonly used for printing Asian fonts.
///
/// # Field Parameter
public struct FieldParameter: ZPLCommandConvertible {
    /// Direction
    ///
    /// Default: `.horizontal`
    public var direction: TextDirection
    ///  Additional inter- character gap (in dots)
    ///
    ///  Values: 0 to 9999
    ///
    ///  Default: 0 if no value is entered
    public var gap: Int
    public var command: String {
        "^FP\(direction.rawValue),\(gap)"
    }
    
    /// Field Parameter.
    ///
    /// - Parameters:
    ///   - direction: Direction.
    ///   - gap: Additional inter- character gap (in dots). 0 to 9999.
    public init(direction: TextDirection, gap: Int) {
        self.direction = direction
        self.gap = gap
    }
}
