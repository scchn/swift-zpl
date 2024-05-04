//
//  ZPLImageReader.swift
//  
//
//  Created by chen on 2024/5/4.
//

import Foundation

public protocol ZPLImageReader {
    var width: Int { get }
    var height: Int { get }
    
    func getRed(x: Int, y: Int) -> UInt8
    func getGreen(x: Int, y: Int) -> UInt8
    func getBlue(x: Int, y: Int) -> UInt8
}
