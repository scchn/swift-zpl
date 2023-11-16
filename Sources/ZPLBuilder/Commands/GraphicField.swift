//
//  GraphicField.swift
//
//
//  Created by chen on 2023/11/11.
//

import CoreGraphics

/// The ^GF command allows you to download graphic field data directly into the printer’s bitmap storage area.
/// This command follows the conventions for any other field, meaning a field orientation is included.
/// The graphic field data can be placed at any location within the bitmap space.
///
/// # Graphic Field
public struct GraphicField: ZPLCommandConvertible {
    public let command: String
    
    private init() {
        command = ""
    }
    
    public init(cgImage: CGImage, size: CGSize, isCompressed: Bool = false) {
        let width = Int(size.width)
        let height = Int(size.height)
        
        self.command = cgImage.zplCommand(width: width, height: height, isCompressed: isCompressed) ?? ""
    }
}

#if canImport(AppKit)
import AppKit

extension GraphicField {
    public init(image: NSImage, size: CGSize, isCompressed: Bool = false) {
        if let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) {
            self.init(cgImage: cgImage, size: size, isCompressed: isCompressed)
        } else {
            self.init()
        }
    }
}
#elseif canImport(UIKit)
import UIKit

extension GraphicField {
    public init(image: UIImage, size: CGSize, isCompressed: Bool = false) {
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage, size: size, isCompressed: isCompressed)
        } else {
            self.init()
        }
    }
}
#endif
