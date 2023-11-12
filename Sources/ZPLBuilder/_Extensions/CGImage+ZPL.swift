//
//  CGImage+ZPL.swift
//
//
//  Created by chen on 2023/11/10.
//

#if canImport(CoreGraphics)
import CoreGraphics

extension CGImage {
    func zplCommand(width: Int, height: Int) -> String? {
        guard let (body, bytesPerRow, totalBytes) = makeBody(width: width, height: height) else {
            return nil
        }
        
        return "^GFA,\(totalBytes),\(totalBytes),\(bytesPerRow)," + body
    }
    
    private func makeBody(width: Int, height: Int) -> (image: String, bytesPerRow: Int, totalBytes: Int)? {
        guard let cgImage = resized(width: width, height: height),
              let imageData = cgImage.dataProvider?.data,
              let imagePtr = CFDataGetBytePtr(imageData)
        else {
            return nil
        }

        // ----- Constants -----
        let blackThreshold = 380
        // ---------------------
        
        let bytesPerRow = width / 8 + (width.isMultiple(of: 8) ? 0 : 1)
        let totalBytes = bytesPerRow * height
        var body = ""

        for y in 0..<height {
            var components: [Character] = []

            for x in 0..<width {
                let bytesPerPixel = cgImage.bitsPerPixel / 8
                let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
                let r = Int(imagePtr[offset])
                let g = Int(imagePtr[offset + 1])
                let b = Int(imagePtr[offset + 2])
                let totalColor = r + g + b

                components.append(totalColor > blackThreshold ? "0" : "1")

                if components.count == 8 || x == width - 1 {
                    body.append(fourByteBinary(binaryStr: String(components)))
                    components.removeAll()
                }
            }

            body.append("\n")
        }

        return (body, bytesPerRow, totalBytes)
    }
    
    private func fourByteBinary(binaryStr: String) -> String {
        let decimal = Int(binaryStr, radix: 2) ?? 0
        
        if (decimal > 15) {
            return String(decimal, radix: 16).uppercased()
        } else {
            return "0" + String(decimal, radix: 16).uppercased()
        }
    }
}
#endif
