//
//  GraphicEllipse.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// The ^GE command produces an ellipse in the label format.
///
/// # Graphic Ellipse
public struct GraphicEllipse: ZPLCommandConvertible {
    /// Ellipse width (in dots)
    ///
    /// Values: 3 to 4095 (larger values are replaced with 4095)
    ///
    /// Default: value used for thickness (t) or 1
    public var width: Int
    /// Ellipse height (in dots)
    ///
    /// Values: 3 to 4095
    ///
    /// Default: value used for thickness (t) or 1
    public var height: Int
    /// Border thickness (in dots)
    ///
    /// Values: 2 to 4095
    ///
    /// Default: 1
    public var lineWidth: Int
    ///  Line color
    ///
    ///  Default: `.black`
    public var lineColor: FieldColor
    public var command: String {
        "^GE\(width),\(height),\(lineWidth),\(lineColor.rawValue)"
    }
    
    /// Graphic Ellipse.
    ///
    /// - Parameters:
    ///   - width: Ellipse width (in dots). 3 to 4095 (larger values are replaced with 4095).
    ///   - height: Ellipse height (in dots). 2 to 4095.
    ///   - lineWidth: Border thickness (in dots).
    ///   - lineColor: Line color.
    public init(width: Int, height: Int, lineWidth: Int, lineColor: FieldColor = .black) {
        self.width = width
        self.height = height
        self.lineWidth = lineWidth
        self.lineColor = lineColor
    }
}
