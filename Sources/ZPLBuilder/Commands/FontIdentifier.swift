//
//  FontIdentifier.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// All built-in fonts are referenced using a one-character identifier. 
/// The ^CW command assigns a single alphanumeric character to a font stored in DRAM, memory card, EPROM, or Flash.
///
/// **Font Identifier**
///
/// If the assigned character is the same as that of a built-in font, the downloaded font is used in place of the built-in font. 
/// The new font is printed on the label wherever the format calls for the built-in font.
/// If used in place of a built-in font, the change is in effect only until power is turned off.
///
/// If the assigned character is different, the downloaded font is used as an additional font. 
/// The assignment remains in effect until a new command is issued or the printer is turned off.
public struct FontIdentifier: ZPLCommandConvertible {
    /// Letter of existing font to be substituted, or new font to be added
    ///
    /// Values: A through Z and 0 to 9
    ///
    /// Default: a one-character entry is required
    public var font: Character
    /// Device to store font in (optional)
    public var deviceLocation: DeviceLocation
    /// Name of the downloaded font to be substituted for the built-in, or as an additional font
    ///
    /// Values: any name up to 8 characters
    ///
    /// Default: if a name is not specified, UNKNOWN is used
    public var tableName: String
    /// Extension
    public var tableFormat: FontFormat
    public var command: String {
        "^CW\(font),\(deviceLocation.rawValue):\(tableName).\(tableFormat.rawValue)"
    }
    
    /// Font Identifier.
    ///
    /// - Parameters:
    ///   - font: Letter of existing font to be substituted, or new font to be added. A through Z and 0 to 9.
    ///   - deviceLocation: Device to store font in.
    ///   - tableName: Name of the downloaded font to be substituted for the built-in, or as an additional font. Any name up to 8 characters.
    ///   - tableFormat: Extension.
    public init(font: Character, deviceLocation: DeviceLocation, tableName: String, tableFormat: FontFormat) {
        self.font = font
        self.deviceLocation = deviceLocation
        self.tableName = tableName
        self.tableFormat = tableFormat
    }
}
