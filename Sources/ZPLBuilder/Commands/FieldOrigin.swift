//
//  FieldOrigin.swift
//
//
//  Created by chen on 2023/11/14.
//

import Foundation

/// The ^FO command sets a field origin, relative to the label home (^LH) position.
/// ^FO sets the upper-left corner of the field area by defining points along the x-axis and y-axis independent of the rotation.
///
/// # Field Origin
public struct FieldOrigin: ZPLCommandConvertible {
    /// x-axis location (in dots)
    ///
    /// Values: 0 to 32000
    ///
    /// Default: 0
    public var x: Int
    /// y = y-axis location (in dots)
    ///
    /// Values: 0 to 32000
    ///
    /// Default: 0
    public var y: Int
    /// z = justification
    ///
    /// Default: last accepted ^FW value or ^FW default
    ///
    /// The parameter is only supported in firmware versions V60.14.x, V50.14.x, or later.
    public var justification: FieldJustification?
    public var command: String {
        if let justification {
            "^FO\(x),\(y),\(justification.rawValue)"
        } else {
            "^FO\(x),\(y)"
        }
    }
}
