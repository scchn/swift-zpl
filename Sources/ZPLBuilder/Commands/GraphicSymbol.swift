//
//  GraphicSymbol.swift
//  
//
//  Created by chen on 2023/11/12.
//

import Foundation

extension GraphicSymbol {
    public enum Symbol: Character {
        /// ®(Registered Trade Mark)
        case registeredTradeMark = "A"
        /// © (Copyright)
        case copyright = "B"
        /// ™ (Trade Mark)
        case rradeMark = "C"
        /// Underwriters Laboratories approval
        case ul = "D"
        /// Canadian Standards Association approval
        case csa = "E"
    }
}

/// The ^GS command enables you to generate the registered trademark, copyright symbol, and other symbols.
///
/// # Graphic Symbol
public struct GraphicSymbol: ZPLCommandConvertible {
    /// Symbol
    public var symbol: Symbol
    /// Field orientation
    ///
    /// Default: N or last ^FW value
    public var orientation: Orientation?
    /// Character height proportional to width (in dots)
    ///
    /// Values: 0 to 32000
    ///
    /// Default: last ^CF value
    public var width: Int?
    /// Character width proportional to height (in dots)
    ///
    /// Values: 0 to 32000
    ///
    /// Default: last ^CF value
    public var height: Int?
    public var command: String {
        "^GS\(orientation?.rawValue ?? ""),\(height?.description ?? ""),\(width?.description ?? "")" +
        "^FD\(symbol.rawValue)"
    }
    
    /// Graphic Symbol.
    ///
    /// - Parameters:
    ///   - symbol: Symbol.
    ///   - orientation: Field orientation.
    ///   - width: Character height proportional to width (in dots). 0 to 32000
    ///   - height: Character width proportional to height (in dots). 0 to 32000
    public init(symbol: Symbol, orientation: Orientation? = nil, width: Int? = nil, height: Int? = nil) {
        self.symbol = symbol
        self.orientation = orientation
        self.width = width
        self.height = height
    }
}
