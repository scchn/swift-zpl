//
//  GraphicDiagonalLine.swift
//  
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// The ^GD command produces a straight diagonal line on a label. 
/// This can be used in conjunction with other graphic commands to create a more complex figure.
///
/// # Graphic Diagonal Line
public struct GraphicDiagonalLine: ZPLCommandConvertible {
    /// Box width (in dots)
    ///
    /// Values: 3 to 32000
    ///
    /// Default: value of t (thickness) or 3
    public var width: Int
    /// Box height (in dots)
    ///
    /// Values: 3 to 32000
    ///
    /// Default: value of t (thickness) or 3
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
    /// Orientation (direction of the diagonal)
    ///
    /// Default: `.right`
    public var orientation: DiagonalOrientation
    public var command: String {
        "^GD\(width),\(height),\(lineWidth),\(lineColor.rawValue),\(orientation.rawValue)"
    }
    
    /// Graphic Diagonal Line.
    ///
    /// - Parameters:
    ///   - width: Box width (in dots). 3 to 32000.
    ///   - height: Box height (in dots). 3 to 32000.
    ///   - lineWidth: Border thickness (in dots). 1 to 32000.
    ///   - lineColor: Line color.
    ///   - orientation: Orientation (direction of the diagonal).
    public init(width: Int, height: Int, lineWidth: Int, lineColor: FieldColor = .black, orientation: DiagonalOrientation) {
        self.width = width
        self.height = height
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.orientation = orientation
    }
}
