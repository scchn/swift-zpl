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
    
    func test_field_hexadecimal() {
        let cmd1 = FieldHexadecimalIndicator(indicator: "\\")
        XCTAssertEqual(cmd1.command, "^FH\\")
        
        let cmd2 = FieldHexadecimal(indicator: "\\", code: 0x7E)
        XCTAssertEqual(cmd2.command, "\\7E")
    }
    
    func test_use_font_name_to_call_font() {
        let cmd = UseFontNameToCallFont(
            deviceLocation: .e, 
            orientation: .normal,
            tableName: "A",
            tableFormat: .fnt,
            height: 40,
            width: 30
        )
        
        XCTAssertEqual("^A@N,40,30,E:A.FNT", cmd.command)
    }
    
    func test_host_directory_list() {
        let cmd = HostDirectoryList(deviceLocation: .e, objectName: "*", extension: "FNT")
        XCTAssertEqual(cmd.command, "^HWE:*.FNT")
    }
}
