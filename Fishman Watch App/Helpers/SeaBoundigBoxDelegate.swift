//
//  SeaBoundigBoxDelegate.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 02.09.2025.
//

import Foundation

protocol SeaBoundigBoxDelegate: AnyObject {
    func boxDidChangeWith(box: FishBoundingBox)
}
