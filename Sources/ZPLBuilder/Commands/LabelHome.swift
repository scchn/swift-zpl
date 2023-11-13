//
//  LabelHome.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^LH command sets the label home position.
///
/// # Label Home
///
/// The default home position of a label is the upper-left corner (position 0,0 along the x and y axis). 
/// This is the axis reference point for labels. Any area below and to the right of this point is available for printing. 
/// The ^LH command changes this reference point.
/// For instance, when working with preprinted labels, use this command to move the reference point below the preprinted area.
///
/// This command affects only fields that come after it. 
/// 
/// - Remark: It is recommended to use ^LH as one of the first commands in the label format.
public struct LabelHome: ZPLCommandConvertible {
    /// x-axis position (in dots)
    ///
    /// Values: 0 to 32000
    ///
    /// Initial Value at Power Up: 0 or last permanently saved value
    public var x: Int
    /// y-axis position (in dots)
    ///
    /// Values: 0 to 32000
    ///
    /// Initial Value at Power Up: 0 or last permanently saved value
    public var y: Int
    public var command: String {
        "^LH\(x),\(y)"
    }
    
    /// Label Home.
    /// 
    /// - Parameters:
    ///   - x: x-axis position (in dots). 0 to 32000.
    ///   - y: y-axis position (in dots). 0 to 32000.
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
