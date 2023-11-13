//
//  FieldTypeset.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// The ^FT command sets the field position, relative to the home position of the label designated by the ^LH command.
/// The typesetting origin of the field is fixed with respect to the contents of the field and does not change with rotation.
///
/// # Field Typeset
///
/// The ^FT command is capable of concantination of fields.
public struct FieldTypeset: ZPLCommandConvertible {
    /// x-axis location (in dots)
    ///
    /// Values: 0 to 32000
    ///
    /// Default: position after last formatted text field
    public var x: Int
    ///  y-axis location (in dots)
    ///
    ///  Values: 0 to 32000
    ///
    ///  Default: position after last formatted text field
    public var y: Int
    /// Justification
    ///
    /// The parameter is only supported in firmware version V60.14.x, V50.14.x, or later.
    ///
    /// Values:
    /// * 0 = left justification
    /// * 1 = right justification
    /// * 2 = auto justification (script dependent)
    ///
    /// Default: last accepted ^FW value or ^FW default
    ///
    /// **Left Justified**
    /// * Text: For examples, see Field Interactions on page 1547.
    /// * Bar Codes: Origin is base of bar code, at left edge
    /// * Graphic Boxes: Origin is bottom-left corner of the box
    /// Images Origin is bottom-left corner of the image area
    ///
    /// **Right Justified**
    /// * Text: For examples, see Field Interactions on page 1547.
    /// * Bar Codes: Origin is base of bar code, at right edge
    /// * Graphic Boxes: Origin is bottom-right corner of the box
    /// * Images: Origin is bottom-right corner of the image area
    public var justification: FieldJustification?
    public var command: String {
        if let justification {
            "^FT\(x),\(y),\(justification.rawValue)"
        } else {
            "^FT\(x),\(y)"
        }
    }
    
    /// Field Typeset.
    ///
    /// - Parameters:
    ///   - x: x-axis location (in dots). 0 to 32000.
    ///   - y: y-axis location (in dots). 0 to 32000.
    ///   - justification: Justification.
    public init(x: Int, y: Int, justification: FieldJustification? = nil) {
        self.x = x
        self.y = y
        self.justification = justification
    }
}
