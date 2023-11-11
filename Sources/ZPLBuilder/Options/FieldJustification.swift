//
//  FieldJustification.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

public enum FieldJustification: Int {
    /// Left justification
    case left
    /// Right justification
    case right
    /// Auto justification (script dependent)
    ///
    /// The parameter is only supported in firmware versions V60.14.x, V50.14.x, or later.
    ///
    /// The auto justification option may cause unexpected results if variable fields or bidirectional text are used with ^FT.
    /// For best results with bidirectional text and/or variable fields, use either the left of right justification options.
    case auto
}
