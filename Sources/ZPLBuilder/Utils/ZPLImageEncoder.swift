//
//  ZPLImageEncoder.swift
//
//
//  Created by chen on 2023/11/18.
//

import Foundation
import CoreGraphics
import OSLog

@available(macOS 11.0, iOS 14.0, *)
private let logger = Logger(subsystem: "ZPLBuidler", category: "ZPLImageEncoder")

public struct ZPLImage {
    public var bytesPerRow: Int
    public var totalBytes: Int
    public var data: String
}

public class ZPLImageEncoder {
    /// The default encoder of ``GraphicField``.
    public static let shared = ZPLImageEncoder()
    
    private static let componentValueSize = 8
    
    public var isCompressed: Bool = false
    public var blackThreshold = 383
    
    public init() {
        
    }
    
    public func encode(cgImage: CGImage, targetSize: CGSize?) -> ZPLImage? {
        let width = if let width = targetSize?.width {
            Int(width)
        } else {
            cgImage.width
        }
        let height = if let height = targetSize?.height {
            Int(height)
        } else {
            cgImage.height
        }
        
        guard width > 0, height > 0, cgImage.width > 0, cgImage.height > 0 else {
            if #available(macOS 11.0, iOS 14.0, *) {
                logger.notice("Invalid image size or target size.")
            }
            return nil
        }
        guard let cgImage = width == cgImage.width && height == cgImage.height
                ? cgImage
                : cgImage.resized(width: width, height: height)
        else {
            if #available(macOS 11.0, iOS 14.0, *) {
                logger.notice("Failed to resize image.")
            }
            return nil
        }
        guard let data = isCompressed ? makeCompressedData(cgImage: cgImage) : makeData(cgImage: cgImage),
              !data.isEmpty
        else {
            if #available(macOS 11.0, iOS 14.0, *) {
                logger.notice("Failed to encode image.")
            }
            return nil
        }
        
        let bytesPerRow = width / Self.componentValueSize + (width.isMultiple(of: Self.componentValueSize) ? 0 : 1)
        let totalBytes = bytesPerRow * height
        
        return ZPLImage(bytesPerRow: bytesPerRow, totalBytes: totalBytes, data: data)
    }
    
    private func enumerateComponents(cgImage: CGImage, _ block: (Int, Int, String, Bool) -> Void) {
        guard let imageData = cgImage.dataProvider?.data,
              let imagePtr = CFDataGetBytePtr(imageData)
        else {
            return
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = cgImage.bitsPerPixel / 8
        let bytesPerRow = cgImage.bytesPerRow
        
        for y in 0..<height {
            let baseOffset = y * bytesPerRow
            var componentValue = 0
            var pos = 0
            
            for x in 0..<width {
                let offset = baseOffset + (x * bytesPerPixel)
                let r = Int(imagePtr[offset])
                let g = Int(imagePtr[offset + 1])
                let b = Int(imagePtr[offset + 2])
                let sum = r + g + b
                
                componentValue <<= 1
                
                if sum <= blackThreshold {
                    componentValue += 1
                }
                
                pos += 1
                
                if pos == Self.componentValueSize || x == width - 1 {
                    if pos != Self.componentValueSize {
                        componentValue <<= Self.componentValueSize - pos
                    }
                    
                    let components = if componentValue <= 15 {
                        "0" + String(componentValue, radix: 16, uppercase: true)
                    } else {
                        String(componentValue, radix: 16, uppercase: true)
                    }
                    
                    block(x, y, components, x == width - 1)
                    componentValue = 0
                    pos = 0
                }
            }
        }
    }
}

extension ZPLImageEncoder {
    private func makeData(cgImage: CGImage) -> String? {
        var body = ""
        
        enumerateComponents(cgImage: cgImage) { x, y, components, _ in
            body.append(components)
        }
        
        return body
    }
}

extension ZPLImageEncoder {
    private func makeCompressedData(cgImage: CGImage) -> String? {
        let divisable = cgImage.width.isMultiple(of: Self.componentValueSize)
        let bytesPerRow = cgImage.width / Self.componentValueSize + (divisable ? 0 : 1)
        let maxRepeatCount = bytesPerRow * 2
        var repeatCount = 1
        var aux: Character?
        var currLine: [Character] = []
        var prevLine: [Character] = []
        var body: [Character] = []
        
        enumerateComponents(cgImage: cgImage) { x, y, components, isEOL in
            for component in components {
                guard let _aux = aux else {
                    aux = component
                    continue
                }
                
                if aux == component && repeatCount < 419 {
                    repeatCount += 1
                } else {
                    currLine.append(contentsOf: encodeComponent(_aux, repeatCount: repeatCount))
                    repeatCount = 1
                    aux = component
                }
            }
            
            guard isEOL else {
                return
            }
            
            if repeatCount >= maxRepeatCount && aux == "0" {
                currLine.append(",")
            } else if repeatCount >= maxRepeatCount && aux == "F" {
                currLine.append("!")
            } else if let aux {
                currLine.append(contentsOf: encodeComponent(aux, repeatCount: repeatCount))
            }
            
            repeatCount = 1
            aux = nil
            
            if currLine == prevLine {
                body.append(":")
            } else {
                body.append(contentsOf: currLine)
            }
            
            prevLine = currLine
            currLine.removeAll()
        }
        
        return String(body)
    }
    
    private func encodeComponent(_ component: Character, repeatCount: Int) -> [Character] {
        guard repeatCount > 20 else {
            return [encodingTable[repeatCount]!, component]
        }
        
        let multi = repeatCount / 20 * 20
        let remainder = repeatCount % 20
        
        if remainder != 0 {
            return [encodingTable[multi]!, encodingTable[remainder]!, component]
        } else {
            return [encodingTable[multi]!, component]
        }
    }
}

private let encodingTable: [Int: Character] = [
    1: "G",
    2: "H",
    3: "I",
    4: "J",
    5: "K",
    6: "L",
    7: "M",
    8: "N",
    9: "O",
    10: "P",
    11: "Q",
    12: "R",
    13: "S",
    14: "T",
    15: "U",
    16: "V",
    17: "W",
    18: "X",
    19: "Y",
    20: "g",
    40: "h",
    60: "i",
    80: "j",
    100: "k",
    120: "l",
    140: "m",
    160: "n",
    180: "o",
    200: "p",
    220: "q",
    240: "r",
    260: "s",
    280: "t",
    300: "u",
    320: "v",
    340: "w",
    360: "x",
    380: "y",
    400: "z",
]
