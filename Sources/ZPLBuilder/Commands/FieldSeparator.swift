//
//  FieldSeparator.swift
//  
//
//  Created by chen on 2023/11/14.
//

import Foundation

/// The ^FS command denotes the end of the field definition.
/// Alternatively, ^FS command can also be issued as a single ASCII control code SI (Control-O, hexadecimal 0F).
///
/// # Field Separator
///
/// It is recommended to place an ^FS after every command that creates a printable line.
public struct FieldSeparator: ZPLCommandConvertible {
    public let command: String = "^FS"
}
