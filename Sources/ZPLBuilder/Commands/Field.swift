//
//  Field.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

public struct Field: ZPLCommandConvertible {
    public let zpl: ZPL
    public let command: String
    
    /// Field.
    ///
    /// - Parameters:
    ///   - x: x-axis location (in dots). 0 to 32000
    ///   - y: y-axis location (in dots). 0 to 32000
    ///   - justification: 
    ///     Justification. 
    ///
    ///     Default: last accepted ^FW value or ^FW default.
    ///
    ///     The parameter is only supported in firmware versions V60.14.x, V50.14.x, or later.
    ///
    ///   - body: Field contents.
    public init(x: Int, y: Int, justification: FieldJustification? = nil, @ZPLBuilder body: () -> ZPLComponent) {
        let header = FieldOrigin(x: x, y: y, justification: justification)
        let body = body().zpl.commands
        let footer = FieldSeparator()
        
        self.zpl = .init(commands: [header] + body + [footer])
        self.command = header.command + body.map(\.command).joined() + footer.command
    }
}
