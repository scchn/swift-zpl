//
//  LabelLength.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^LL command defines the length of the label. 
/// This command is necessary when using continuous media (media not divided into separate labels by gaps, spaces, notches, slots, or holes).
/// This command is not persistent across a power cycle unless a ^JUS is received.
///
/// ~~See also zpl.label_length_always on page 1152. Label Length~~
///
/// **Label Length**
///
/// To affect the current label and be compatible with existing printers, ^LL must come before the first ^FS (Field Separator) command. 
/// Once you have issued ^LL, the setting is retained until you turn off the printer or send a new ^LL command.
public struct LabelLength: ZPLCommandConvertible {
    /// Defines the label length.
    ///
    /// Values: 1 to 32000, not to exceed the maximum label size.
    /// * While the printer accepts any value for this parameter, the amount of memory installed determines the maximum length of the label.
    ///
    /// Default: typically set through the LCD (if applicable), or to the maximum label length capability of the printer.
    public var length: Int
    public var command: String {
        "^LL\(length)"
    }
    
    /// Label Length.
    ///
    /// - Parameter length: Defines the label length. 1 to 32000, not to exceed the maximum label size.
    public init(_ length: Int) {
        self.length = length
    }
}
