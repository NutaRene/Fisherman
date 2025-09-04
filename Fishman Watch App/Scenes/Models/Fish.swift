//
//  Fish.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import Foundation

enum FishType {
    case nonPredatory
    case predatory
    case faune
}

struct Fish: Identifiable {
    var imageName: String
    var id: UUID
    var type: FishType
    var isCatched: Bool
    var position: CGPoint
    var isLeftDirection: Bool
    
    var speed: CGFloat = 0.2
    var bobPhase: Double = Double.random(in: 0...(.pi * 2)) // для вертикальных колебаний
    var bobAmplitude: CGFloat = CGFloat.random(in: 2...6)
    var bobFrequency: Double = Double.random(in: 0.8...1.8)
}
