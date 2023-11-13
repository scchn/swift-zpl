//
//  ZPLComponent.swift
//
//
//  Created by chen on 2023/11/11.
//

import Foundation

public protocol ZPLComponent {
    /// The ZPL command represented by this component.
    var zpl: ZPL {
        get
    }
}
