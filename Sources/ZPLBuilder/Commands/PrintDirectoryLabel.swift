//
//  PrintDirectoryLabel.swift
//
//
//  Created by 陳世爵 on 2023/12/4.
//

import Foundation

/// The ^WD command is used to print a label listing bar codes, objects stored in DRAM, or fonts.
/// For bar codes, the list shows the name of the bar code.
/// For fonts, the list shows the name of the font, the number to use with ^A command, and size.
/// For objects stored in DRAM, the list shows the name of the object, extension, size, and option flags.
/// All lists are enclosed in a double-line box.
public struct PrintDirectoryLabel: ZPLCommandConvertible {
    /// Source device — optional
    ///
    /// Values: R:, E:, B:, A: and Z:
    /// 
    /// Default: R:
    public var deviceLocation: DeviceLocation
    /// object name — optional
    ///
    /// Values: 1 to 8 alphanumeric characters
    ///
    /// Default: *
    ///
    /// The use of a ? (question mark) is also allowed.
    public var objectName: String
    /// extension — optional
    ///
    /// .TTF and .TTE are only supported in firmware version V60.14.x, V50.14.x, or later.
    ///
    /// Values: any extension conforming to Zebra conventions .FNT = font
    /// * .BAR = bar code
    /// * .ZPL = stored ZPL format
    /// * .GRF = GRF graphic
    /// * .CO = memory cache
    /// * .DAT = font encoding
    /// * .BAS = ZBI encrypted program .BAE = ZBI encrypted program .STO = data storage
    /// * .PNG = PNG graphic * = all objects
    /// * .TTF = TrueType Font
    /// * .TTE = True Type Extension
    ///
    /// Default: *
    ///
    /// The use of a ? (question mark) is also allowed.
    public var `extension`: String
    
    public var command: String {
        "^WD\(deviceLocation):\(objectName).\(`extension`)"
    }
    
    /// Print Directory Label
    ///
    /// ```
    /// PrintDirectoryLabel(deviceLocation: .z, objectName: "*", extension: "*")
    /// PrintDirectoryLabel(deviceLocation: .e, objectName: "*", extension: "FNT")
    /// ```
    public init(deviceLocation: DeviceLocation, objectName: String, `extension`: String) {
        self.deviceLocation = deviceLocation
        self.objectName = objectName
        self.`extension` = `extension`
    }
}
