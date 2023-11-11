//
//  SetDarkness.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// The ~SD command allows you to set the darkness of printing. 
/// ~SD is the equivalent of the darkness setting parameter on the control panel display.
///
/// **Set Darkness**
public struct SetDarkness: ZPLCommandConvertible {
    /// Desired darkness setting (two-digit number)
    ///
    /// Values: 0 to 30
    ///
    /// Default: last permanently saved value
    public var value: Int
    public var command: String {
        "~SD\(String(format: "%02d", value))"
    }
    
    /// Set Darkness.
    ///
    /// - Parameter value: Desired darkness setting. 0 to 30
    public init(_ value: Int) {
        self.value = value
    }
}
