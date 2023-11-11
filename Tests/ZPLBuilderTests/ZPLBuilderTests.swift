import XCTest
@testable import ZPLBuilder

final class ZPLBuilderTests: XCTestCase {
    func test_zpl_builder() {
        let settings = ZPL {
            LabelHome(x: 0, y: 0)
            PrintWidth(10)
            LabelLength(20)
        }
        let body = ZPL {
            Field(x: 0, y: 0) {
                FieldData(text: "hello")
            }
        }
        let zpl = ZPL {
            settings
            body
        }
        let types: [ZPLCommandConvertible.Type] = [LabelHome.self, PrintWidth.self, LabelLength.self, Field.self, FieldData.self]
        
        for (index, command) in zpl.commands.enumerated() {
            XCTAssertTrue(type(of: command) == types[index])
        }
    }
}
