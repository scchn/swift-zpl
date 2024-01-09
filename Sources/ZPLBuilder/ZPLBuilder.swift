//
//  ZPLBuilder.swift
//  
//
//  Created by chen on 2023/11/11.
//

import Foundation

@resultBuilder
public struct ZPLBuilder {
    public static func buildBlock(_ components: ZPLComponent...) -> ZPLComponent {
        return ZPL(commands: components.flatMap(\.zpl.commands))
    }
    
    public static func buildArray(_ components: [ZPLComponent]) -> ZPLComponent {
        return ZPL(commands: components.flatMap(\.zpl.commands))
    }
    
    public static func buildEither(first component: ZPLComponent) -> ZPLComponent {
        return component
    }
    
    public static func buildEither(second component: ZPLComponent) -> ZPLComponent {
        return component
    }
    
    public static func buildOptional(_ component: ZPLComponent?) -> ZPLComponent {
        if let component {
            return component
        } else {
            return ZPL(commands: [])
        }
    }
}
