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
    
    public var string: String {
        "^XA" + commands.map(\.command).joined() + "^XZ"
    }
}
