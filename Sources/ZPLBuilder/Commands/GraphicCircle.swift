//
//  GraphicCircle.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// The ^GC command produces a circle on the printed label. 
/// The command parameters specify the diameter (width) of the circle, outline thickness, and color.
/// Thickness extends inward from the outline.
///
/// # Graphic Circle
public struct GraphicCircle: ZPLCommandConvertible {
    /// Circle diameter (in dots)
    ///
    /// Values: 3 to 4095 (larger values are replaced with 4095)
    ///
    /// Default: 3
    public var diameter: Int
    /// Border thickness (in dots)
    ///
    /// Values: 2 to 4095
    ///
    /// Default: 1
    public var lineWidth: Int
    /// Line color
    ///
    /// Default: `.black`
    public var lineColor: FieldColor
    public var command: String {
        "^GC\(diameter),\(lineWidth),\(lineColor.rawValue)"
    }
    
    /// Graphic Circle.
    ///
    /// - Parameters:
    ///   - diameter: Circle diameter (in dots). 3 to 4095 (larger values are replaced with 4095).
    ///   - lineWidth: Border thickness (in dots). 2 to 4095.
    ///   - lineColor: Line color.
    public init(diameter: Int, lineWidth: Int, lineColor: FieldColor = .black) {
        self.diameter = diameter
        self.lineWidth = lineWidth
        self.lineColor = lineColor
    }
}
