//
//  DiagonalOrientation.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

public enum DiagonalOrientation: String {
    /// R(or /). Right-leaning diagonal
    ///
    /// ```
    /// ....
    /// | /|
    /// |/ |
    /// ''''
    /// ```
    case right = "R"
    /// L(or \). Left-leaning diagonal
    ///
    /// ```
    /// ....
    /// |\ |
    /// | \|
    /// ''''
    /// ```
    case left = "L"
}
