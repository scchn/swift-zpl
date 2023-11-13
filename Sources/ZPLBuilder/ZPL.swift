//
//  ZPL.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

public struct ZPL: ZPLComponent {
    public var zpl: ZPL {
        self
    }
    
    public var commands: [ZPLCommandConvertible]
    
    public init(commands: [ZPLCommandConvertible]) {
        self.commands = commands
    }
    
    public init(@ZPLBuilder body: () -> ZPLComponent) {
        self.commands = body().zpl.commands
    }
    
    /// Returns a ZPL command string that starts with `^XA` and ends with `^XZ`.
    public var string: String {
        "^XA" + commands.map(\.command).joined() + "^XZ"
    }
}
