//
//  GraphicBox.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^GB command is used to draw boxes and lines as part of a label format. 
/// Boxes and lines are used to highlight important information, divide labels into distinct areas, or to improve the appearance of a label.
/// The same format command is used for drawing either boxes or lines.
///
/// **Graphic Box**
public struct GraphicBox: ZPLCommandConvertible {
    /// Box width (in dots)
    ///
    /// Values: value of `lineWidth` to 32000
    ///
    /// Default: value used for thickness (t) or 1
    public var width: Int
    /// Box height (in dots)
    ///
    /// Values: value of `lineWidth` to 32000
    ///
    /// Default: value used for thickness (t) or 1
    public var height: Int
    /// Border thickness (in dots)
    ///
    /// Values: 1 to 32000
    ///
    /// Default: 1
    public var lineWidth: Int
    /// Line color
    ///
    /// Default: `.black`
    public var lineColor: FieldColor
    /// Degree of corner-rounding
    ///
    /// Values: 0 (no rounding) to 8 (heaviest rounding)
    ///
    /// Default: 0
    public var rounding: Int
    public var command: String {
        "^GB\(width),\(height),\(lineWidth),\(lineColor.rawValue),\(rounding)"
    }
    
    /// Graphic Box.
    ///
    /// - Parameters:
    ///   - width: Box width (in dots). Value of `lineWidth` to 32000
    ///   - height: Box height (in dots). Value of `lineWidth` to 32000
    ///   - lineWidth: Border thickness (in dots).
    ///   - lineColor: Line color.
    ///   - rounding: Degree of corner-rounding. 0 (no rounding) to 8 (heaviest rounding)
    public init(width: Int, height: Int, lineWidth: Int = 1, lineColor: FieldColor = .black, rounding: Int = 0) {
        self.width = width
        self.height = height
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.rounding = rounding
    }
}
