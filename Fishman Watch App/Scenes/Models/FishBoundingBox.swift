//
//  FishBoundingBox.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 12.08.2025.
//

import Foundation

struct FishBoundingBox {
    let minX: CGFloat
    let maxX: CGFloat
    let minY: CGFloat
    let maxY: CGFloat
    
    init(minX: CGFloat = 0.0, maxX: CGFloat = 0.0, minY: CGFloat = 0.0, maxY: CGFloat = 0.0) {
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
    }
}
