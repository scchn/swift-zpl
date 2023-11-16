//
//  CGImage+Ext.swift
//
//
//  Created by chen on 2023/11/10.
//

import CoreGraphics

extension CGImage {
    func resized(width: Int, height: Int) -> CGImage? {
        guard let ctx = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        ctx.draw(self, in: rect)
        
        return ctx.makeImage()
    }
}
