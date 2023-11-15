//
//  CGImage+ZPL.swift
//
//
//  Created by chen on 2023/11/10.
//

#if canImport(CoreGraphics)
import CoreGraphics

/*
 Reference: http://www.jcgonzalez.com/java-image-to-zpl-example
 */

extension CGImage {
    func zplCommand(width: Int, height: Int, isCompressed: Bool) -> String? {
        guard self.width > 0 && self.height > 0 && width > 0 && height > 0,
              let (_body, bytesPerRow, totalBytes) = isCompressed
                ? makeCompressedBody(width: width, height: height)
                : makeBody(width: width, height: height)
        else {
            return nil
        }
        
        return "^GFA,\(totalBytes),\(totalBytes),\(bytesPerRow)," + _body
    }
}

// MARK: - No Compression

extension CGImage {
    private func makeBody(width: Int, height: Int) -> (image: String, bytesPerRow: Int, totalBytes: Int)? {
        let _cgImage = width == self.width && height == self.height
            ? self
            : resized(width: width, height: height)
        
        guard let cgImage = _cgImage,
              let imageData = cgImage.dataProvider?.data,
              let imagePtr = CFDataGetBytePtr(imageData)
        else {
            return nil
        }
        
        // ----- Constants -----
        let blackThreshold = 380
        let componentValueSize = 8
        // ---------------------
        
        let bytesPerPixel = cgImage.bitsPerPixel / 8
        let bytesPerRow = width / componentValueSize + (width.isMultiple(of: componentValueSize) ? 0 : 1)
        let totalBytes = bytesPerRow * height
        var body = ""
        
        for y in 0..<height {
            let baseOffset = y * cgImage.bytesPerRow
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
                
                if pos == componentValueSize || x == width - 1 {
                    if pos != componentValueSize {
                        componentValue <<= componentValueSize - pos
                    }
                    
                    let component = if componentValue <= 15 {
                        "0" + String(componentValue, radix: 16, uppercase: true)
                    } else {
                        String(componentValue, radix: 16, uppercase: true)
                    }
                    
                    body.append(component)
                    componentValue = 0
                    pos = 0
                }
            }

            body.append("\n")
        }
        
        return (body, bytesPerRow, totalBytes)
    }
}

// MARK: - Compression

extension CGImage {
    private func makeCompressedBody(width: Int, height: Int) -> (image: String, bytesPerRow: Int, totalBytes: Int)? {
        let _cgImage = width == self.width && height == self.height
            ? self
            : resized(width: width, height: height)
        
        guard let cgImage = _cgImage,
              let imageData = cgImage.dataProvider?.data,
              let imagePtr = CFDataGetBytePtr(imageData)
        else {
            return nil
        }

        // ----- Constants -----
        let blackThreshold = 380
        let componentValueSize = 8
        // ---------------------
        
        let bytesPerPixel = cgImage.bitsPerPixel / 8
        let divisable = width.isMultiple(of: componentValueSize)
        let bytesPerRow = width / componentValueSize + (divisable ? 0 : 1)
        let totalBytes = bytesPerRow * height
        
        let maxRepeatCount = bytesPerRow * 2
        var repeatCount = 1
        var aux: Character?
        var currLine: [Character] = []
        var prevLine: [Character] = []
        var body: [Character] = []
        
        for y in 0..<height {
            let baseOffset = y * cgImage.bytesPerRow
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
                
                if pos == componentValueSize || x == width - 1 {
                    defer {
                        componentValue = 0
                        pos = 0
                    }
                    
                    if pos != componentValueSize {
                        componentValue <<= componentValueSize - pos
                    }
                    
                    let component = if componentValue <= 15 {
                        "0" + String(componentValue, radix: 16, uppercase: true)
                    } else {
                        String(componentValue, radix: 16, uppercase: true)
                    }
                    
                    for now in component {
                        guard let _aux = aux else {
                            aux = now
                            continue
                        }
                        
                        if aux == now && repeatCount < 400 {
                            repeatCount += 1
                        } else {
                            currLine.append(contentsOf: encodedComponent(for: _aux, repeatCount: repeatCount))
                            repeatCount = 1
                            aux = now
                        }
                    }
                }
            }
            
            if repeatCount >= maxRepeatCount && aux == "0" {
                currLine.append(",")
            } else if repeatCount >= maxRepeatCount && aux == "F" {
                currLine.append("!")
            } else if let aux {
                currLine.append(contentsOf: encodedComponent(for: aux, repeatCount: repeatCount))
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
        
        return (String(body), bytesPerRow, totalBytes)
    }
    
    private func encodedComponent(for component: Character, repeatCount: Int) -> [Character] {
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
#endif
