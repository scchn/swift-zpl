//
//  Field.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

public struct Field: ZPLCommandConvertible {
    public let command: String
    
    /// Field.
    ///
    /// - Parameters:
    ///   - x: x-axis location (in dots). 0 to 32000
    ///   - y: y-axis location (in dots). 0 to 32000
    ///   - justification: Justification. The parameter is only supported in firmware versions V60.14.x, V50.14.x, or later.
    ///   - body: Field contents.
    public init(x: Int, y: Int, justification: FieldJustification? = nil, @ZPLBuilder body: () -> ZPLComponent) {
        let header = if let justification {
            "^FO\(x),\(y),\(justification.rawValue)"
        } else {
            "^FO\(x),\(y)"
        }
        let body = body().zpl.commands.map(\.command).joined()
        let footer = "^FS"
        
        command = header + body + footer
    }
}
