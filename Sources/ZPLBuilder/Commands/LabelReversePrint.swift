//
//  LabelReversePrint.swift
//
//
//  Created by chen on 2023/11/12.
//

import Foundation

/// The ^LR command reverses the printing of all fields in the label format. 
/// It allows a field to appear as white over black or black over white.
///
/// # Label Reverse Print
///
/// Using the ^LR is identical to placing an ^FR command in all current and subsequent fields.
///
/// Comments: The ^LR setting remains active unless turned off by ^LRN or the printer is turned off.
///
/// Only fields following this command are affected.
///
/// - Important: GB needs to be used together with ^LR.
public struct LabelReversePrint: ZPLCommandConvertible {
    /// Reverse print all fields
    public var isEnabled: Bool
    public var command: String {
        "^LR\(isEnabled ? "Y" : "N")"
    }
    
    public init(enabled: Bool) {
        self.isEnabled = enabled
    }
}
