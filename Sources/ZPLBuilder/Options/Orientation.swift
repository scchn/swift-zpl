//
//  Orientation.swift
//  
//
//  Created by chen on 2023/11/11.
//

import Foundation

public enum Orientation: String {
    /// Normal.
    case normal = "N"
    /// Rotated 90 degrees (clockwise).
    case rotated90 = "R"
    /// Inverted 180 degrees.
    case inverted180 = "I"
    /// Read from bottom up, 270 degrees.
    case bottomUp270 = "B"
}
