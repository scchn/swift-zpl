//
//  ZPLCGImageReader.swift
//  
//
//  Created by chen on 2024/5/4.
//

#if canImport(CoreGraphics)
import Foundation
import CoreGraphics
import OSLog

public struct ZPLCGImageReader: ZPLImageReader {
    private let imageData: CFData
    private let imagePtr: UnsafePointer<UInt8>
    private let bytesPerPixel: Int
    private let bytesPerRow: Int
    
    public var width: Int
    public var height: Int
    
    public init?(cgImage: CGImage, targetSize: CGSize?) {
        guard cgImage.width > 0, cgImage.height > 0 else {
            return nil
        }
        
        self.width = {
            if let targetWidth = targetSize?.width {
                return Int(targetWidth)
            } else {
                return cgImage.width
            }
        }()
        self.height = {
            if let targetHeight = targetSize?.height {
                return Int(targetHeight)
            } else {
                return cgImage.height
            }
        }()
        
        guard
            self.width > 0, self.height > 0,
            let cgImage = width == cgImage.width && height == cgImage.height
                ? cgImage
                : cgImage.resized(width: width, height: height),
            let imageData = cgImage.dataProvider?.data,
            let imagePtr = CFDataGetBytePtr(imageData)
        else {
            return nil
        }
        
        self.imageData = imageData
        self.imagePtr = imagePtr
        self.bytesPerPixel = cgImage.bitsPerPixel / 8
        self.bytesPerRow = cgImage.bytesPerRow
    }
    
    private func offset(x: Int, y: Int) -> Int {
        y * bytesPerRow + x * bytesPerPixel
    }
    
    public func getRed(x: Int, y: Int) -> UInt8 {
        imagePtr[offset(x: x, y: y)]
    }
    
    public func getGreen(x: Int, y: Int) -> UInt8 {
        imagePtr[offset(x: x, y: y) + 1]
    }
    
    public func getBlue(x: Int, y: Int) -> UInt8 {
        imagePtr[offset(x: x, y: y) + 2]
    }
}
#endif
