//
//  FieldReversePrint.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// The ^FR command allows a field to appear as white over black or black over white.
/// When printing a field and the ^FR command has been used, 
/// the color of the output is the reverse of its background.
///
/// # Field Reverse Print
///
/// The ^FR command applies to only one field and has to be specified each time.
///
/// - Remark: When multiple ^FR commands are going to be used,
///   it might be more convenient to use the ^LR command.
public struct FieldReversePrint: ZPLCommandConvertible {
    public let command = "^FR"
    
    public init() {
    }
}
