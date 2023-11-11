//
//  BarcodeInterpretation.swift
//  
//
//  Created by chen on 2023/11/11.
//

import Foundation

public enum BarcodeInterpretation: Equatable {
    case hidden
    case top
    case bottom
    
    var visibility: String {
        self != .hidden ? "Y" : "N"
    }
    
    var top: String {
        self == .top ? "Y" : "N"
    }
}
