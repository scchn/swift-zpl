//
//  UseFontNameToCallFont.swift
//
//
//  Created by 陳世爵 on 2023/12/4.
//

import Foundation

/// The ^A@ command uses the complete name of a font, rather than the character designation used in ^A.
/// Once a value for ^A@ is defined, it represents that font until a new font name is specified by ^A@.
public struct UseFontNameToCallFont: ZPLCommandConvertible {
    /// Drive location of font
    ///
    /// Values: R:, E:, B:, and A: Default: R:
    public var deviceLocation: DeviceLocation
    /// Font name
    ///
    /// Values: any valid font
    ///
    /// Default: if an invalid or no name is entered, the default set by ^CF is used If no font has been specified in ^CF, font A is used.
    ///
    /// The font named carries over on all subsequent ^A@ commands without a font name.
    public var tableName: String
    /// Extension
    /// Values:
    /// * FNT = font
    /// * TTF = TrueType Font
    /// * TTE = TrueType Extension
    ///
    /// - Note: TTE is only supported in firmware version V60.14.x, V50.14.x, or later.
    public var tableFormat: FontFormat
    /// Field orientation
    ///
    /// Values:
    /// * N = normal
    /// * R = rotates 90 degrees (clockwise)
    /// * I = inverted 180 degrees
    /// * B = read from bottom up, 270 degrees 
    ///
    /// Default: N or the last ^FW value
    public var orientation: Orientation
    /// Character height (in dots)
    ///
    /// Default:
    ///
    /// Specifies magnification by w (character width) or the last accepted ^CF value. 
    /// Uses the base height if none is specified.
    ///
    /// Scalable:
    ///
    /// The value is the height in dots of the entire character block.
    /// Magnification factors are unnecessary, because characters are scaled.
    ///
    /// Bitmapped:
    ///
    /// The value is rounded to the nearest integer multiple of the font’s base height,
    /// then divided by the font’s base height to give a magnification nearest limit.
    public var height: Int
    /// Width (in dots)
    ///
    /// Default:
    ///
    /// Specifies magnification by h (height) or the last accepted ^CF value.
    /// Specifies the base width is used if none is specified.
    ///
    /// Scalable:
    /// 
    /// The value is the width in dots of the entire character block.
    /// Magnification factors are unnecessary, because characters are scaled.
    ///
    /// Bitmapped:
    ///
    /// The value rounds to the nearest integer multiple of the font’s base width,
    /// then divided by the font’s base width to give a magnification nearest limit.
    public var width: Int
    public var command: String {
        "^A@\(orientation.rawValue),\(height),\(width),\(deviceLocation.rawValue):\(tableName).\(tableFormat.rawValue)"
    }
    
    public init(deviceLocation: DeviceLocation, orientation: Orientation, tableName: String, tableFormat: FontFormat, height: Int, width: Int) {
        self.deviceLocation = deviceLocation
        self.orientation = orientation
        self.tableName = tableName
        self.tableFormat = tableFormat
        self.height = height
        self.width = width
    }
}
