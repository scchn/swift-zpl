//
//  SelectEncodingTable.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

/// The ^SE command is used to select the desired ZPL or ZPL II encoding table.
///
/// **Select Encoding Table**
public struct SelectEncodingTable: ZPLCommandConvertible {
    /// Location of encoding table
    public var deviceLocation: DeviceLocation
    /// Name of encoding table
    ///
    /// Values: 1 to 8 alphanumeric characters
    /// * `tableName`.DAT
    public var tableName: String
    public var command: String {
        "^SE\(deviceLocation.rawValue):\(tableName).DAT"
    }
    
    /// Select Encoding Table.
    /// 
    /// - Parameters:
    ///   - deviceLocation: Location of encoding table.
    ///   - tableName: Name of encoding table.
    public init(deviceLocation: DeviceLocation, tableName: String) {
        self.deviceLocation = deviceLocation
        self.tableName = tableName
    }
}
