//
//  FontFormat.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

public enum FontFormat: String {
    case font = "FNT"
    case trueTypeFont = "TTF"
    /// `TTE` is only supported in firmware version V60.14.x, V50.14.x, or later.
    case trueTypeExtension = "TTE"
}
