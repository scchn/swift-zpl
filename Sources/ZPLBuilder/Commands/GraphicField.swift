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
    
    private init() {
        command = ""
    }
    
    public init(cgImage: CGImage, size: CGSize) {
        self.command = cgImage.zplCommand(width: Int(size.width), height: Int(size.height)) ?? ""
    }
    
    public init(cgImage: CGImage, width: Int) {
        let height = Int(Double(width) * Double(cgImage.height) / Double(cgImage.width))
        
        self.command = cgImage.zplCommand(width: width, height: height) ?? ""
    }
    
    public init(cgImage: CGImage, height: Int) {
        let width = Int(Double(height) * Double(cgImage.width) / Double(cgImage.height))
        
        self.command = cgImage.zplCommand(width: width, height: height) ?? ""
    }
}
#endif

#if canImport(AppKit)
extension GraphicField {
    public init(image: NSImage, size: CGSize) {
        if let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) {
            self.init(cgImage: cgImage, size: size)
        } else {
            self.init()
        }
    }
    
    public init(image: NSImage, width: Int) {
        if let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) {
            self.init(cgImage: cgImage, width: width)
        } else {
            self.init()
        }
    }
    
    public init(image: NSImage, height: Int) {
        if let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) {
            self.init(cgImage: cgImage, height: height)
        } else {
            self.init()
        }
    }
}
#elseif canImport(UIKit)
extension GraphicField {
    public init(image: UIImage, size: CGSize) {
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage, size: size)
        } else {
            self.init()
        }
    }
    
    public init(image: UIImage, width: Int) {
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage, width: width)
        } else {
            self.init()
        }
    }
    
    public init(image: UIImage, height: Int) {
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage, height: height)
        } else {
            self.init()
        }
    }
}
#endif
