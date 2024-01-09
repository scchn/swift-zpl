//
//  CGImageTests.swift
//
//
//  Created by chen on 2023/11/12.
//

#if canImport(CoreGraphics)
import XCTest
@testable import ZPLBuilder

class CGImageTests: XCTestCase {
    func test_resize() {
        let oldWidth = 100
        let oldHeight = 50
        let newWidth = oldWidth / 2
        let newHeight = oldHeight / 2
        let oldCGImage = makeCGImage(width: oldWidth, height: oldHeight)
        
        guard let newCGImage = oldCGImage.resized(width: newWidth, height: newHeight) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(newCGImage.width, newWidth)
        XCTAssertEqual(newCGImage.height, newHeight)
    }
}

func makeCGImage(width: Int, height: Int) -> CGImage {
    let size = CGSize(width: width, height: height)
    
#if canImport(AppKit)
    return NSImage(size: size, flipped: false, drawingHandler: { _ in true })
        .cgImage(forProposedRect: nil, context: nil, hints: nil)!
#else
    return UIGraphicsImageRenderer(size: size).image(actions: { _ in })
        .cgImage!
#endif
}
#endif
