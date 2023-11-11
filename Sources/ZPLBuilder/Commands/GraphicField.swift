//
//  GraphicField.swift
//
//
//  Created by chen on 2023/11/11.
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

/// The ^GF command allows you to download graphic field data directly into the printer’s bitmap storage area.
/// This command follows the conventions for any other field, meaning a field orientation is included.
/// The graphic field data can be placed at any location within the bitmap space.
///
/// **Graphic Field**
public struct GraphicField: ZPLCommandConvertible {
    public let command: String
    
    public init(cgImage: CGImage, size: CGSize) {
        self.command = cgImage.zplCommand(width: Int(size.width), height: Int(size.height)) ?? ""
    }
}
#endif

#if canImport(AppKit)
extension GraphicField {
    public init(image: NSImage, size: CGSize) {
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        
        self.command = cgImage?.zplCommand(width: Int(size.width), height: Int(size.height)) ?? ""
    }
}
#elseif canImport(UIKit)
extension GraphicField {
    public init(image: UIImage, size: CGSize) {
        let cgImage = image.cgImage
        
        self.command = cgImage?.zplCommand(width: Int(size.width), height: Int(size.height)) ?? ""
    }
}
#endif
