//
//  ZPLGeometryUtils.swift
//  
//
//  Created by chen on 2023/11/16.
//

import Foundation

public enum ZPLGeometryUtils {
    public static func rect(aspectRatio: CGSize, insideRect boundingRect: CGRect) -> CGRect {
        makeRect(aspectRatio: aspectRatio, boundingRect: boundingRect)
    }
    
    public static func rect(aspectRatio: CGSize, boundingSize: CGSize) -> CGRect {
        let rect = CGRect(origin: .zero, size: boundingSize)
        return makeRect(aspectRatio: aspectRatio, boundingRect: rect)
    }
    
    public static func size(aspectRatio: CGSize, boundingSize: CGSize) -> CGSize {
        rect(aspectRatio: aspectRatio, boundingSize: boundingSize).size
    }
    
    public static func size(aspectRatio: CGSize, fillWidth width: Int) -> CGSize {
        let height = Int(Double(width) * Double(aspectRatio.height) / Double(aspectRatio.width))
        return .init(width: width, height: height)
    }
    
    public static func size(aspectRatio: CGSize, fillHeight height: Int) -> CGSize {
        let width = Int(Double(height) * Double(aspectRatio.width) / Double(aspectRatio.height))
        return .init(width: width, height: height)
    }
}

private func makeRect(aspectRatio: CGSize, boundingRect: CGRect) -> CGRect {
    let wMulti = boundingRect.width / aspectRatio.width
    let hMulti = boundingRect.height / aspectRatio.height
    var size = boundingRect.size
    var origin = boundingRect.origin
    
    if hMulti < wMulti {
        size.width = boundingRect.height / aspectRatio.height * aspectRatio.width
        origin.x = boundingRect.midX - size.width / 2
    } else if wMulti < hMulti {
        size.height = boundingRect.width / aspectRatio.width * aspectRatio.height
        origin.y = boundingRect.midY - size.height / 2
    }
    
    return .init(origin: origin, size: size)
}
