//
//  ZPLCommandConvertible.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

public protocol ZPLCommandConvertible: ZPLComponent {
    /// Returns ZPL command string.
    var command: String {
        get
    }
}

extension ZPLCommandConvertible {
    public var zpl: ZPL {
        .init(commands: [self])
    }
}
