//
//  FontFormat.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

public enum FontFormat: String {
    case fnt = "FNT"
    case ttf = "TTF"
    /// `.tte` is only supported in firmware version V60.14.x, V50.14.x, or later.
    case tte = "TTE"
}
