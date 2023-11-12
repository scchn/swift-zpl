//
//  TextJustification.swift
//  
//
//  Created by chen on 2023/11/11.
//

import Foundation

public enum TextJustification: String {
    /// Left
    case left = "L"
    /// Center
    case center = "C"
    /// Right
    case right = "R"
    /// Justified
    ///
    /// If `.justified` is used the last line is left-justified.
    case justified = "J"
}
