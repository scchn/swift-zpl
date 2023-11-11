//
//  CGImageTests.swift
//
//
//  Created by chen on 2023/11/12.
//

#if canImport(AppKit) || canImport(UIKit)
import XCTest
@testable import ZPLBuilder

class CGImageTests: XCTestCase {
    func test_resize() {
        let oldWidth = 1920
        let oldHeight = 1080
        let newWidth = 960
        let newHeight = 540
        
        guard let oldCGImage = makeCGImage(width: oldWidth, height: oldHeight),
              let newCGImage = oldCGImage.resized(width: newWidth, height: newHeight)
        else {
            return
        }
        
        XCTAssertEqual(newCGImage.width, newWidth)
        XCTAssertEqual(newCGImage.height, newHeight)
    }
}

func makeCGImage(width: Int, height: Int) -> CGImage? {
#if canImport(AppKit)
        let image = NSImage(size: CGSize(width: width, height: height))
    
        return image.cgImage(forProposedRect: nil, context: nil, hints: nil)
#else
        let image = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
            .image(actions: { _ in })
    
        return image.cgImage
#endif
}

#endif
