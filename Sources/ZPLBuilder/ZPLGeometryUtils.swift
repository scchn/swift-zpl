//
//  ZPLGeometryUtils.swift
//  
//
//  Created by chen on 2023/11/16.
//

import Foundation
import AVFoundation.AVGeometry

public enum ZPLGeometryUtils {
    public static func size(aspectRatio: CGSize, fillWidth width: Int) -> CGSize {
        let height = Int(Double(width) * Double(aspectRatio.height) / Double(aspectRatio.width))
        return .init(width: width, height: height)
    }
    
    public static func size(aspectRatio: CGSize, fillHeight height: Int) -> CGSize {
        let width = Int(Double(height) * Double(aspectRatio.width) / Double(aspectRatio.height))
        return .init(width: width, height: height)
    }
    
    public static func size(aspectRatio: CGSize, fitBoundingSize boundingSize: CGSize) -> CGSize {
        let rect = CGRect(origin: .zero, size: boundingSize)
        return AVMakeRect(aspectRatio: aspectRatio, insideRect: rect).size
    }
}
