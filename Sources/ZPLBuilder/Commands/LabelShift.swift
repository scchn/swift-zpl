//
//  LabelShift.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^LS command allows for compatibility with Z-130 printer formats that are set for less than full label width. 
/// It is used to shift all field positions to the left so the same commands used on a Z-130 or Z-220 Printer can be used on other Zebra printers.
///
/// **Label Shift**
///
/// IMPORTANT: The ability to save the ^LS command depends on the version of firmware.
public struct LabelShift: ZPLCommandConvertible {
    /// Shift left value (in dots)
    ///
    /// Values: -9999 to 9999
    ///
    /// Initial Value at Power Up: 0
    public var left: Int
    public var command: String {
        "^LS\(left)"
    }
    
    /// Label Shift.
    /// 
    /// - Parameter left: Shift left value (in dots). -9999 to 9999.
    public init(left: Int) {
        self.left = left
    }
}
