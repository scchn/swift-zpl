//
//  ZPLGeometryUtils.swift
//  
//
//  Created by chen on 2023/11/16.
//

import Foundation

public enum ZPLGeometryUtils {
    public static func width(aspectRatio: CGSize, height: Int) -> Int {
        Int(Double(height) * Double(aspectRatio.width) / Double(aspectRatio.height))
    }
    
    public static func height(aspectRatio: CGSize, width: Int) -> Int {
        Int(Double(width) * Double(aspectRatio.height) / Double(aspectRatio.width))
    }
    
    public static func size(aspectRatio: CGSize, height: Int) -> CGSize {
        let width = width(aspectRatio: aspectRatio, height: height)
        return .init(width: width, height: height)
    }
    
    public static func size(aspectRatio: CGSize, width: Int) -> CGSize {
        let height = height(aspectRatio: aspectRatio, width: width)
        return .init(width: width, height: height)
    }
}
