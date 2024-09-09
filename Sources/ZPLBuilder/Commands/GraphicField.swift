//
//  GraphicField.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^GF command allows you to download graphic field data directly into the printer’s bitmap storage area.
/// This command follows the conventions for any other field, meaning a field orientation is included.
/// The graphic field data can be placed at any location within the bitmap space.
///
/// # Graphic Field
public struct GraphicField: ZPLCommandConvertible {
    private let encoder: ZPLImageEncoder
    
    public var image: ZPLImageReader?
    public var command: String {
        guard let image = image, let encoded = encoder.encode(imageReader: image) else {
            return ""
        }
        return "^GFA,\(encoded.totalBytes),\(encoded.totalBytes),\(encoded.bytesPerRow),\(encoded.data)"
    }
    
    private init(encoder: ZPLImageEncoder) {
        self.encoder = encoder
    }
    
    public init(imageReader: ZPLImageReader, encoder: ZPLImageEncoder = .init()) {
        self.encoder = encoder
        self.image = imageReader
    }
}

#if canImport(AppKit)
import AppKit

extension GraphicField {
    public init(image: NSImage, size: CGSize? = nil, encoder: ZPLImageEncoder = .init()) {
        if let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil),
           let image = ZPLCGImageReader(cgImage: cgImage, targetSize: size)
        {
            self.init(imageReader: image, encoder: encoder)
        } else {
            self.init(encoder: encoder)
        }
    }
}
#elseif canImport(UIKit)
import UIKit

extension GraphicField {
    public init(image: UIImage, size: CGSize? = nil, encoder: ZPLImageEncoder = .init()) {
        if let cgImage = image.cgImage,
           let image = ZPLCGImageReader(cgImage: cgImage, targetSize: size)
        {
            self.init(imageReader: image, encoder: encoder)
        } else {
            self.init(encoder: encoder)
        }
    }
}
#endif
