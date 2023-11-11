//
//  FieldData.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^FD command defines the data string for a field. 
/// The field data can be any printable character except those used as command prefixes (^ and ~).
///
/// **Field Data**
///
/// In RFID printers, it can also be used to specify passwords to write to tags.
public struct FieldData: ZPLCommandConvertible {
    /// Data to be printed (all printers), or a password to be written to a RFID tag (rfid printers)
    ///
    /// Values: any data string up to 3072 bytes
    ///
    /// Default: none—a string of characters must be entered
    public var text: String
    public var command: String {
        "^FD\(text)"
    }
    
    /// Field Data.
    ///
    /// - Parameter text: Data to be printed (all printers), or a password to be written to a RFID tag (rfid printers). Any data string up to 3072 bytes
    public init(text: String) {
        self.text = text
    }
}
