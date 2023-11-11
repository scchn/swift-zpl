//
//  BarcodeDefault.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// ^BY. The ^BY command is used to change the default values for the module width (in dots), 
/// the wide bar to narrow bar width ratio and the bar code height (in dots). 
/// It can be used as often as necessary within a label format.
///
/// **Bar Code Field Default**
///
/// Comments: Once a ^BY command is entered into a label format, it stays in effect until another ^BY command is encountered.
public struct BarcodeDefault: ZPLCommandConvertible {
    /// Module width (in dots).
    ///
    /// Values: 1 to 10
    ///
    /// Initial Value at Power Up: 2
    public var moduleWidth: Int = 2
    /// Wide bar to narrow bar width ratio.
    ///
    /// Values: 2.0 to 3.0, in 0.1 increments
    ///
    /// This parameter has no effect on fixed-ratio bar codes. Default: 3.0
    public var ratio: Int = 3
    /// Bar code height (in dots).
    ///
    /// Initial Value at Power Up: 10
    public var height: Int = 10
    public var command: String {
        "^BY\(moduleWidth),\(ratio),\(height)"
    }
    
    /// Barcode field default.
    ///
    /// - Parameters:
    ///   - moduleWidth: Module width (in dots). 1 to 10
    ///   - ratio: Wide bar to narrow bar width ratio. 2.0 to 3.0, in 0.1 increments.
    ///   - height: Bar code height (in dots).
    public init(moduleWidth: Int, ratio: Int, height: Int) {
        self.moduleWidth = moduleWidth
        self.ratio = ratio
        self.height = height
    }
}
