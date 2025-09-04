//
//  Helper.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import SwiftUI
import WatchKit

struct Helper {
    static let watchScreenBounds = WKInterfaceDevice.current().screenBounds

    static let fishHeight: CGFloat = 40.0
    
    static let hookButtonHeight: CGFloat = 30.0
    static let toolbarButtonHeight: CGFloat = 25.0
    
    static let fishingLineColor: Color = Color.init(hex: "#574A45")
    
    static let nonPredatoryFishImageNames: [String] = ["NP1", "NP2", "NP3", "NP4", "NP5", "NP6", "NP7", "NP8", "NP9", "NP10", "NP11", "NP12", "NP13", "NP14", "NP15", "NP16", "NP17", "NP18"]
    
    static let predatoryFishImageNames: [String] = ["P1", "P2", "P3", "P4", "P5", "P6"]
}
