//
//  FieldOrientation.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^FW command sets the default orientation for all command fields that have an orientation (rotation) parameter (and in x.14 sets the default justification for all commands with a justification parameter). 
/// Fields can be rotated 0, 90, 180, or 270 degrees clockwise by using this command.
/// In x.14, justification can be left, right, or auto.
///
/// **Field Orientation**
///
/// The ^FW command affects only fields that follow it.
/// Once you have issued a ^FW command, the setting is retained until you turn off the printer or send a new ^FW command to the printer.
public struct FieldOrientation: ZPLCommandConvertible {
    /// Rotate field
    ///
    /// Initial Value at Power Up: `.normal`
    public var orientation: Orientation
    /// Justification.
    ///
    /// Default: `.auto` for ``FieldTextBlock`` and left for all other commands
    ///
    /// The parameter is available only with printers with firmware version V60.14.x, V50.14.x, or later.
    public var alignment: FieldJustification
    public var command: String {
        "^FW\(orientation.rawValue),\(alignment.rawValue)"
    }
    
    /// Field Orientation.
    ///
    /// - Parameters:
    ///   - orientation: Rotate field.
    ///   - alignment: Justification.
    public init(orientation: Orientation, alignment: FieldJustification) {
        self.orientation = orientation
        self.alignment = alignment
    }
}
