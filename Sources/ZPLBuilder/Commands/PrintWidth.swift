//
//  PrintWidth.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^PW command allows you to set the print width.
///
/// **Print Width**
public struct PrintWidth: ZPLCommandConvertible {
    /// Label width (in dots)
    ///
    /// Values: 2, to the width of the label.
    /// * If the value exceeds the width of the label, the width is set to the label’s maximum size.
    ///
    /// Default: last permanently saved value
    public var width: Int
    public var command: String {
        "^PW\(width)"
    }
    
    /// Print Width.
    ///
    /// - Parameter width: Label width (in dots). 2, to the width of the label.
    public init(_ width: Int) {
        self.width = width
    }
}
