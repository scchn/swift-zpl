//
//  ZPLGeometryUtils.swift
//  
//
//  Created by chen on 2023/11/16.
//

import Foundation

public enum ZPLGeometryUtils {
    public static func size(aspectRatio: CGSize, fillWidth width: Int) -> CGSize {
        let height = Int(Double(width) * Double(aspectRatio.height) / Double(aspectRatio.width))
        return .init(width: width, height: height)
    }
    
    public static func size(aspectRatio: CGSize, fillHeight height: Int) -> CGSize {
        let width = Int(Double(height) * Double(aspectRatio.width) / Double(aspectRatio.height))
        return .init(width: width, height: height)
    }
}

#if canImport(AVFoundation)
import AVFoundation.AVGeometry

extension ZPLGeometryUtils {
    public static func rect(aspectRatio: CGSize, insideRect boundingRect: CGRect) -> CGRect {
        AVMakeRect(aspectRatio: aspectRatio, insideRect: boundingRect)
    }
    
    public static func rect(aspectRatio: CGSize, fitBoundingSize boundingSize: CGSize) -> CGRect {
        let rect = CGRect(origin: .zero, size: boundingSize)
        return AVMakeRect(aspectRatio: aspectRatio, insideRect: rect)
    }
    
    public static func size(aspectRatio: CGSize, fitBoundingSize boundingSize: CGSize) -> CGSize {
        rect(aspectRatio: aspectRatio, fitBoundingSize: boundingSize).size
    }
}
#endif
