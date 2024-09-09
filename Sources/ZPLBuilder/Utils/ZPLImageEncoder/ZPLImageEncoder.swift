//
//  ZPLImageEncoder.swift
//
//
//  Created by chen on 2023/11/18.
//

import Foundation

/// Encodes images into ZPL format.
/// Supports both compressed and uncompressed encoding modes.
public final class ZPLImageEncoder: Sendable {
    private static let componentValueSize = 8
    
    /// If true, uses compression for encoding; if false, generates uncompressed data.
    public let isCompressed: Bool
    
    /// Threshold for determining black/white pixels.
    public let whiteThreshold: Int
    
    /// Initializes the encoder.
    /// - Parameters:
    ///   - isCompressed: Use compression mode. Default: false.
    ///   - whiteThreshold: Black/white threshold. Default: 383 (50% gray).
    public init(isCompressed: Bool = false, whiteThreshold: Int = 383) {
        self.isCompressed = isCompressed
        self.whiteThreshold = whiteThreshold
    }

    
    public func encode(imageReader: ZPLImageReader) -> ZPLImage? {
        guard let data = isCompressed ? makeCompressedData(imageReader: imageReader) : makeData(imageReader: imageReader),
              !data.isEmpty
        else {
            return nil
        }
        
        let bytesPerRow = imageReader.width / Self.componentValueSize + (imageReader.width.isMultiple(of: Self.componentValueSize) ? 0 : 1)
        let totalBytes = bytesPerRow * imageReader.height
        
        return ZPLImage(bytesPerRow: bytesPerRow, totalBytes: totalBytes, data: data)
    }
    
    private func enumerateComponents(imageReader: ZPLImageReader, _ block: (Int, Int, String, Bool) -> Void) {
        let width = imageReader.width
        let height = imageReader.height
        
        for y in 0..<height {
            var componentValue = 0
            var pos = 0
            
            for x in 0..<width {
                let color = Int(imageReader.getRed(x: x, y: y))
                    + Int(imageReader.getGreen(x: x, y: y))
                    + Int(imageReader.getBlue(x: x, y: y))
                
                componentValue <<= 1
                
                if color <= whiteThreshold {
                    componentValue += 1
                }
                
                pos += 1
                
                if pos == Self.componentValueSize || x == width - 1 {
                    if pos != Self.componentValueSize {
                        componentValue <<= Self.componentValueSize - pos
                    }
                    
                    let components: String
                    
                    if componentValue <= 15 {
                        components = "0" + String(componentValue, radix: 16, uppercase: true)
                    } else {
                        components = String(componentValue, radix: 16, uppercase: true)
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
    private func makeData(imageReader: ZPLImageReader) -> String? {
        var body = ""
        
        enumerateComponents(imageReader: imageReader) { x, y, components, _ in
            body.append(components)
        }
        
        return body
    }
}

extension ZPLImageEncoder {
    private func makeCompressedData(imageReader: ZPLImageReader) -> String? {
        let divisable = imageReader.width.isMultiple(of: Self.componentValueSize)
        let bytesPerRow = imageReader.width / Self.componentValueSize + (divisable ? 0 : 1)
        let maxRepeatCount = bytesPerRow * 2
        var repeatCount = 1
        var aux: Character?
        var currLine: [Character] = []
        var prevLine: [Character] = []
        var body: [Character] = []
        
        enumerateComponents(imageReader: imageReader) { x, y, components, isEOL in
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
