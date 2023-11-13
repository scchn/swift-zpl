//
//  TextBlock.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^TB command prints a text block with defined width and height. 
/// The text block has an automatic word- wrap function. If the text exceeds the block height, the text is truncated.
/// This command supports complex text layout features.
///
/// # Text Blocks
///
/// This command is available only for printers with firmware version V60.14.x, V50.14.x, or later. 
///
/// - Remark: ^TB is the preferred command for printing fields or blocks of text, instead of ^FB.
///
/// ## Facts about the ^TB command
/// * Justification of ^TB command comes from ^FO, ^FT, or ^FN command.
///   If no justification is determined then the default is auto justification.
/// * Data between `<` and `>` is processed as an escape sequence; for example, `<< >` will print `<`.
/// * The ^TB command has an automatic word-wrap function. Soft hyphens do not print and are not used as a line break position.
public struct TextBlock: ZPLCommandConvertible {
    /// Block rotation
    ///
    /// Default: whatever was specified by the last ^A (which has the default of `FieldOrientation`)
    public var orientation: Orientation
    /// Block width in dots
    ///
    /// Values: 1 to the width of the label in dots
    ///
    /// Default: 1 dot
    public var width: Int
    /// Block height in dots
    ///
    /// Values: 1 to the length of the label in dots
    ///
    /// Default: 1 dot
    public var height: Int
    public var command: String {
        "^TB\(orientation.rawValue),\(width),\(height)"
    }
    
    /// Text Blocks.
    ///
    /// - Parameters:
    ///   - orientation: Block rotation.
    ///   - width: Block width in dots. 1 to the width of the label in dots.
    ///   - height: Block height in dots. 1 to the length of the label in dots.
    public init(orientation: Orientation = .normal, width: Int, height: Int) {
        self.width = width
        self.height = height
        self.orientation = orientation
    }
}
