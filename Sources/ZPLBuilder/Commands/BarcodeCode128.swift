//
//  BarcodeCode128.swift
//  
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^BC command creates the Code 128 barcode, a high-density, variable length, continuous, alphanumeric symbology.
/// It was designed for complexly encoded product identification.
///
/// # Code 128 Barcode (Subsets A, B, and C)
///
/// Code 128 has three subsets of characters. 
/// There are 106 encoded printing characters in each set, and each character can have up to three different meanings,
/// depending on the character subset being used.
/// Each Code 128 character consists of six elements: three bars and three spaces.
///
/// ^BC supports a fixed print ratio.
///
/// Field data (^FD) is limited to the width (or length, if rotated) of the label.
public struct BarcodeCode128: ZPLCommandConvertible {
    /// Field data
    public var data: String
    /// Orientation
    public var orientation: Orientation
    /// Barcode height (in dots)
    ///
    /// Values: 1 to 32000
    ///
    /// Default: value set by ^BY
    public var height: Int
    /// Interpretation line
    ///
    /// The interpretation line can be printed in any font by placing the font command before the barcode command.
    public var interpretation: BarcodeInterpretation
    public var command: String {
        "^BC\(orientation.rawValue),\(height),\(interpretation.visibility),\(interpretation.top),N,N" +
        "^FD\(data)"
    }
    
    /// Barcode 128.
    ///
    /// - Parameters:
    ///     - data: Field data.
    ///     - orientation: Orientation.
    ///     - height: Barcode height (in dots). 1 to 32000.
    ///     - interpretation: Interpretation line.
    public init(data: String, orientation: Orientation = .normal, height: Int, interpretation: BarcodeInterpretation) {
        self.data = data
        self.orientation = orientation
        self.height = height
        self.interpretation = interpretation
    }
}
