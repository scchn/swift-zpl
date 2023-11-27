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
    private let encoder: ZPLImageEncoder
    
    public var cgImage: CGImage?
    public var size: CGSize?
    public var command: String {
        guard let cgImage,
              let encoded = encoder.encode(cgImage: cgImage, targetSize: size)
        else {
            return ""
        }
        return "^GFA,\(encoded.totalBytes),\(encoded.totalBytes),\(encoded.bytesPerRow),\(encoded.data)"
    }
    
    private init(size: CGSize?, encoder: ZPLImageEncoder) {
        self.encoder = encoder
    }
    
    public init(cgImage: CGImage, size: CGSize? = nil, encoder: ZPLImageEncoder = .default) {
        self.encoder = encoder
        self.cgImage = cgImage
        self.size = size
    }
}

#if canImport(AppKit)
import AppKit

extension GraphicField {
    public init(image: NSImage, size: CGSize? = nil, encoder: ZPLImageEncoder = .default) {
        if let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) {
            self.init(cgImage: cgImage, size: size, encoder: encoder)
        } else {
            self.init(size: size, encoder: encoder)
        }
    }
}
#elseif canImport(UIKit)
import UIKit

extension GraphicField {
    public init(image: UIImage, size: CGSize? = nil, encoder: ZPLImageEncoder = .default) {
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage, size: size, encoder: encoder)
        } else {
            self.init(size: size, encoder: encoder)
        }
    }
}
#endif
