//
//  ScalableBitmappedFont.swift
//  
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// The ^A command specifies the font to use in a text field. ^A designates the font for the current ^FD statement or field.
/// The font specified by ^A is used only once for that ^FD entry.
/// If a value for ^A is not specified again, the default ^CF font is used for the next ^FD entry.
///
/// **Scalable/Bitmapped Font**
public struct ScalableBitmappedFont: ZPLCommandConvertible {
    /// Font name
    ///
    /// Values: A through Z, and 0 to 9
    /// * Any font in the printer (downloaded, EPROM, stored fonts, fonts A through Z and 0 to 9).
    ///
    /// IMPORTANT: Parameter f is required. If f is omitted it defaults to the last value of the ^CF command.
    public var font: Character
    /// Field orientation
    public var orientation: Orientation
    /// Character Height (in dots)
    ///
    /// **Scalable**
    ///
    /// Values: 10 to 32000
    ///
    /// Default: last accepted ^CF
    ///
    /// **Bitmapped**
    ///
    /// Values: multiples of height from 1 to 10 times the standard height, in increments of 1
    ///
    /// Default: last accepted ^CF
    public var height: Int
    /// Width (in dots)
    ///
    /// **Scalable**
    ///
    /// Values: 10 to 32000
    ///
    /// Default: last accepted ^CF
    ///
    /// **Bitmapped**
    ///
    /// Values: multiples of width from 1 to 10 times the standard width, in increments of 1 
    ///
    /// Default: last accepted ^CF
    public var width: Int
    public var command: String {
        "^A\(font)\(orientation.rawValue),\(height),\(width)"
    }
    
    /// Scalable/Bitmapped Font.
    ///
    /// - Parameters:
    ///   - font: Font name. A through Z, and 0 to 9.
    ///   - orientation: Field orientation.
    ///   - height: Character Height (in dots). Scalable: 10 to 32000. Bitmapped: Multiples of height from 1 to 10 times the standard height, in increments of 1
    ///   - width: Width (in dots). Scalable: 10 to 32000. Bitmapped: Multiples of width from 1 to 10 times the standard width, in increments of 1.
    public init(font: Character, orientation: Orientation, height: Int, width: Int) {
        self.font = font
        self.orientation = orientation
        self.height = height
        self.width = width
    }
}
