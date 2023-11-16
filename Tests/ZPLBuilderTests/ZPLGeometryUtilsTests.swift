//
//  ZPLGeometryUtilsTests.swift
//
//
//  Created by 陳世爵 on 2023/11/16.
//

import XCTest
@testable import ZPLBuilder

private let imageWidth1 = 20
private let imageHeight1 = 40
private let imageAspectRatio1 = CGSize(width: imageWidth1, height: imageHeight1)

private let imageWidth2 = 40
private let imageHeight2 = 20
private let imageAspectRatio2 = CGSize(width: imageWidth2, height: imageHeight2)

class ZPLGeometryUtilsTests: XCTestCase {
    func test_fill_width() {
        let labelWidth1 = 80
        
        let size1 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio1, fillWidth: labelWidth1)
        XCTAssertEqual(size1, CGSize(width: labelWidth1, height: 160))
        
        let size2 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio2, fillWidth: labelWidth1)
        XCTAssertEqual(size2, CGSize(width: labelWidth1, height: 40))
        
        let labelWidth2 = 10
        
        let size3 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio1, fillWidth: labelWidth2)
        XCTAssertEqual(size3, CGSize(width: labelWidth2, height: 20))
        
        let size4 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio2, fillWidth: labelWidth2)
        XCTAssertEqual(size4, CGSize(width: labelWidth2, height: 5))
    }
    
    func test_fill_height() {
        let labelHeight1 = 80
        
        let size1 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio1, fillHeight: labelHeight1)
        XCTAssertEqual(size1, CGSize(width: 40, height: labelHeight1))
        
        let size2 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio2, fillHeight: labelHeight1)
        XCTAssertEqual(size2, CGSize(width: 160, height: labelHeight1))
        
        let labelHeight2 = 10
        
        let size3 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio1, fillHeight: labelHeight2)
        XCTAssertEqual(size3, CGSize(width: 5, height: labelHeight2))
        
        let size4 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio2, fillHeight: labelHeight2)
        XCTAssertEqual(size4, CGSize(width: 20, height: labelHeight2))
    }
    
    func test_fit_size() {
        let boundingSize = CGSize(width: 80, height: 80)
        
        let size1 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio1, fitBoundingSize: boundingSize)
        XCTAssertEqual(size1, CGSize(width: 40, height: 80))
        
        let size2 = ZPLGeometryUtils.size(aspectRatio: imageAspectRatio2, fitBoundingSize: boundingSize)
        XCTAssertEqual(size2, CGSize(width: 80, height: 40))
    }
}
