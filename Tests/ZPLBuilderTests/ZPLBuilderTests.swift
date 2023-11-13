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
                FieldBlock(width: 1, lines: 1)
                FieldData(text: "hello")
            }
        }
        let zpl = ZPL {
            settings
            body
        }
        let commands = zpl.commands
        let types: [ZPLCommandConvertible.Type] = (
            [LabelHome.self, PrintWidth.self, LabelLength.self] +
            [FieldOrigin.self, FieldBlock.self, FieldData.self, FieldSeparator.self]
        )
        
        XCTAssertEqual(commands.count, types.count)
        
        for (index, command) in zpl.commands.enumerated() {
            XCTAssertTrue(type(of: command) == types[index])
        }
    }
}
