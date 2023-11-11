//
//  BarcodeQR.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^BQ command produces a matrix symbology consisting of an array of nominally square modules arranged in an overall square pattern. 
/// A unique pattern at three of the symbol’s four corners assists in determining bar code size, position, and inclination.
///
/// **QR Code Bar Code**
///
/// A wide range of symbol sizes is possible, along with four levels of error correction. 
/// User-specified module dimensions provide a wide variety of symbol production techniques.
///
/// QR Code Model 1 is the original specification, while QR Code Model 2 is an enhanced form of the symbology.
/// Model 2 provides additional features and can be automatically differentiated from Model 1.
///
/// Model 2 is the recommended model and should normally be used.
///
/// This bar code is printed using field data specified in a subsequent ^FD string.
///
/// Encodable character sets include numeric data, alphanumeric data, 8-bit byte data, and Kanji characters.
public struct BarcodeQR: ZPLCommandConvertible {
    /// Field data
    public var data: String
    /// Magnification factor
    ///
    /// Values: 1 to 10
    ///
    /// Default:
    /// * 1 on 150 dpi printers
    /// * 2 on 200 dpi printers
    /// * 3 on 300 dpi printers
    /// * 6 on 600 dpi printers
    public var magnificationFactor: Int
    public var command: String {
        "^BQN,2,\(magnificationFactor)^FDMM,A\(data)"
    }
    
    /// QR code.
    ///
    /// - Parameters:
    ///   - data: Field data.
    ///   - size: Magnification factor. 1 to 10.
    public init(data: String, size: Int) {
        self.data = data
        self.magnificationFactor = size
    }
}
