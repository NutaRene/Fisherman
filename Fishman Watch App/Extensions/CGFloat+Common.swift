//
//  CGFloat+Common.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 11.08.2025.
//

import Foundation

extension CGFloat {
    func isClose(to other: CGFloat, tolerance: CGFloat) -> Bool {
        return abs(self - other) <= tolerance
    }
}
