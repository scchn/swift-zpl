//
//  ZPLCommandTests.swift
//
//
//  Created by chen on 2023/11/12.
//

import XCTest
@testable import ZPLBuilder

class ZPLCommandTests: XCTestCase {
    func test_ci() {
        let cmd1 = ChangeInternationalEncoding(characterSet: 0)
        XCTAssertEqual(cmd1.command, "^CI0")
        
        let cmd2 = ChangeInternationalEncoding(characterSet: 0, remapping: (21, 36))
        XCTAssertEqual(cmd2.command, "^CI0,21,36")
    }
    
    func test_sd() {
        let cmd1 = SetDarkness(1)
        XCTAssertEqual(cmd1.command, "~SD01")
        
        let cmd2 = SetDarkness(10)
        XCTAssertEqual(cmd2.command, "~SD10")
    }
    
    func test_by() {
        let cmd = BarcodeDefault(moduleWidth: 1, ratio: 2, height: 4)
        XCTAssertEqual(cmd.command, "^BY1,2.0,4")
    }
}
