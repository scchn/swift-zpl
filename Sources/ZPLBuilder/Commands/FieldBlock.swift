//
//  FieldBlock.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^FB command allows you to print text into a defined block type format. 
/// This command formats an ^FD or ^SN string into a block of text using the origin, font, 
/// and rotation specified for the text string.
/// The ^FB command also contains an automatic word-wrap function.
///
/// # Field Block
public struct FieldBlock: ZPLCommandConvertible {
    /// Width of text block line (in dots)
    ///
    /// Values: 0 to the width of the label
    ///
    /// Default: 0 If the value is less than font width or not specified, text does not print.
    public var width: Int
    /// Maximum number of lines in text block
    ///
    /// Values: 1 to 9999
    ///
    /// Default: 1 Text exceeding the maximum number of lines overwrites the last line.
    ///
    /// Changing the font size automatically increases or decreases the size of the block.
    public var lines: Int
    /// Add or delete space between lines (in dots)
    ///
    /// Values: -9999 to 9999
    ///
    /// Default: 0 Numbers are considered to be positive unless preceded by a minus sign.
    ///
    /// Positive values add space; negative values delete space.
    public var spacing: Int
    /// Text justification
    ///
    /// Default: `.left`.
    ///
    /// If `.justified` is used the last line is left-justified.
    public var justification: TextJustification
    /// Hanging indent (in dots) of the second and remaining lines
    ///
    /// Values: 0 to 9999
    ///
    /// Default: 0
    public var hangingIndent: Int = 0
    public var command: String {
        "^FB\(width),\(lines),\(spacing),\(justification.rawValue),\(hangingIndent)"
    }
    
    /// Field Block.
    ///
    /// - Parameters:
    ///   - width: Width of text block line (in dots). 0 to the width of the label.
    ///   - lines: Maximum number of lines in text block. 1 to 9999.
    ///   - spacing: Add or delete space between lines (in dots). -9999 to 9999.
    ///   - justification: Text justification.
    ///   - hangingIndent: Hanging indent (in dots) of the second and remaining lines. 0 to 9999.
    public init(width: Int, lines: Int, spacing: Int = 0, justification: TextJustification = .left, hangingIndent: Int = 0) {
        self.width = width
        self.lines = lines
        self.spacing = spacing
        self.justification = justification
        self.hangingIndent = hangingIndent
    }
}
