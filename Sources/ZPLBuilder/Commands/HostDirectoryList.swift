//
//  HostDirectoryList.swift
//
//
//  Created by 陳世爵 on 2023/12/27.
//

import Foundation

/// ^HW is used to transmit a directory listing of objects in a specific memory area (storage device) back to the host device. This command returns a formatted ASCII string of object names to the host.
///
/// # Host Directory List
///
/// Each object is listed on a line and has a fixed length. The total length of a line is also fixed.
/// Each line listing an object begins with the asterisk (*) followed by a blank space.
/// There are eight spaces for the object name, followed by a period and three spaces for the extension.
/// The extension is followed by two blank spaces, six spaces for the object size, two blank spaces, and three spaces for option flags (reserved for future use).
///
/// The format looks like this:
///
/// ```
/// <STX><CR><LF>
/// DIR R: <CR><LF>
/// *Name.ext(2sp.)(6 obj. sz.)(2sp.)(3 option flags)
/// *Name.ext(2sp.)(6 obj. sz.)(2sp.)(3 option flags)
/// <CR><LF>
/// -xxxxxxx bytes free
/// <CR><LF>
/// <ETX>
/// <STX> = start of text
/// <CR><LR> = carriage return/line feed
/// <ETX> = end on text
/// ```
///
/// The command might be used in a stand-alone file to be issued to the printer at any time.
/// The printer returns the directory listing as soon as possible, based on other tasks it might be performing when the command is received.
///
/// This command, like all ^ (caret) commands, is processed in the order that it is received by the printer.
public struct HostDirectoryList: ZPLCommandConvertible {
    /// Location to retrieve object listing.
    ///
    /// Values: R:, E:, B:, A:and Z:.
    ///
    /// Default: R:.
    public var deviceLocation: DeviceLocation
    /// Object name.
    ///
    /// Values: 1 to 8 alphanumeric characters.
    ///
    /// Default: asterisk (*). A question mark (?) can also be used.
    public var objectName: String
    /// Extension.
    ///
    /// Values: any extension conforming to Zebra conventions.
    ///
    /// Default: asterisk (*). A question mark (?) can also be used.
    public var `extension`: String
    public var command: String {
        "^HW\(deviceLocation.rawValue):\(objectName).\(`extension`)"
    }
    
    /// Host Directory List.
    ///
    /// - Parameters:
    ///   - deviceLocation:
    ///     Location to retrieve object listing.
    ///
    ///   - objectName:
    ///     Object name. 1 to 8 alphanumeric characters.
    ///
    ///     Asterisk (*). A question mark (?) can also be used.
    ///
    ///   - extension:
    ///     Extension.
    ///
    ///     Any extension conforming to Zebra conventions.
    ///
    ///     Asterisk (*). A question mark (?) can also be used.
    public init(deviceLocation: DeviceLocation, objectName: String, extension: String) {
        self.deviceLocation = deviceLocation
        self.objectName = objectName
        self.extension = `extension`
    }
}
