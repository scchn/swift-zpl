//
//  ChangeAlphanumericDefaultFont.swift
//  
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// The ^CF command sets the default font used in your printer. You can use the ^CF command to simplify your programs.
///
/// # Change Alphanumeric Default Font
public struct ChangeAlphanumericDefaultFont: ZPLCommandConvertible {
    /// Specified default font
    ///
    /// Values: A through Z and 0 to 9
    ///
    /// Initial Value at Power Up: A
    public var font: Character
    /// Individual character width (in dots)
    ///
    /// Values: 0 to 32000
    /// Initial Value at Power Up: 9
    public var height: Int?
    /// individual character width (in dots)
    ///
    /// Values: 0 to 32000
    /// 
    /// Initial Value at Power Up: 5 or last permanent saved value
    public var width: Int?
    public var command: String {
        "^CF\(font),\(height?.description ?? ""),\(width?.description ?? "")"
    }
    
    /// Change Alphanumeric Default Font.
    ///
    /// - Parameters:
    ///   - font: Specified default font. A through Z and 0 to 9.
    ///   - height: Individual character width (in dots). 0 to 32000.
    ///   - width: individual character width (in dots). 0 to 32000.
    public init(font: Character, height: Int? = nil, width: Int? = nil) {
        self.font = font
        self.width = width
        self.height = height
    }
}
