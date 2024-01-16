//
//  String+Big5.swift
//
//
//  Created by 陳世爵 on 2024/1/16.
//

#if canImport(CoreFoundation.CFString) && canImport(CoreFoundation.CFStringEncodingExt)
import Foundation

extension String.Encoding {
    static var big5: String.Encoding {
        let _encoding = CFStringEncoding(CFStringEncodings.big5.rawValue)
        let encoding = CFStringConvertEncodingToNSStringEncoding(_encoding)
        
        return .init(rawValue: encoding)
    }
}
#endif
