//
//  ZPLGeometryUtilsTests.swift
//
//
//  Created by scchn on 2023/11/16.
//

import XCTest
@testable import ZPLBuilder

let image20X40 = CGSize(width: 20, height: 40)
let image40X20 = CGSize(width: 40, height: 20)

class ZPLGeometryUtilsTests: XCTestCase {
    func test_long_label() {
        let labelRect = CGRect(x: 10, y: 20, width: 40, height: 80)
        
        let r1 = ZPLGeometryUtils.rect(aspectRatio: image20X40, insideRect: labelRect)
        XCTAssertEqual(r1, .init(x: 10, y: 20, width: 40, height: 80))
        
        let r2 = ZPLGeometryUtils.rect(aspectRatio: image40X20, insideRect: labelRect)
        XCTAssertEqual(r2, .init(x: 10, y: 50, width: 40, height: 20))
    }
    
    func test_wide_label() {
        let labelRect = CGRect(x: 10, y: 20, width: 80, height: 40)
        
        let r1 = ZPLGeometryUtils.rect(aspectRatio: image20X40, insideRect: labelRect)
        XCTAssertEqual(r1, .init(x: 40, y: 20, width: 20, height: 40))
        
        let r2 = ZPLGeometryUtils.rect(aspectRatio: image40X20, insideRect: labelRect)
        XCTAssertEqual(r2, .init(x: 10, y: 20, width: 80, height: 40))
    }
    
    func test_fit_size() {
        let labelRect = CGRect(x: 10, y: 20, width: 80, height: 80)
        
        let r1 = ZPLGeometryUtils.rect(aspectRatio: image20X40, insideRect: labelRect)
        XCTAssertEqual(r1, CGRect(x: 30, y: 20, width: 40, height: 80))
        
        let r2 = ZPLGeometryUtils.rect(aspectRatio: image40X20, insideRect: labelRect)
        XCTAssertEqual(r2, CGRect(x: 10, y: 40, width: 80, height: 40))
    }
}
