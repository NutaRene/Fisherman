//
//  BoatViewModel.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import SwiftUI

@Observable
final class BoatViewModel {
    let boatImageWidth: CGFloat = 60.0
    
    var crownValue: Double = 0.0
    private var previousCrownValue: Double = 0.0
    var isFacingLeft: Bool = true
    
    var isCatching: Bool = false
    
    private(set) var boundingBox: FishBoundingBox = FishBoundingBox()
    
    private(set) var fishingLineMinY: CGFloat = 0.0
    private(set) var fishingLineMaxY: CGFloat = 0.0
    private(set) var fishingLineHeight: CGFloat = 0.0
    private var fishingLineMaxHeight: CGFloat = 0.0
    private var fishingLineIncreaseHeightTimer: Timer?
    private var fishingLineDecreaseHeightTimer: Timer?
    private let fishingLineUpdateHeightInterval: TimeInterval = 1.0 / 60.0

    let offsetY: CGFloat = 8.0
    
    init() {}
    
    func updateCatchState(value: Bool) {
        self.isCatching = value
        self.resetCatching()
        
        self.fishingLineIncreaseHeightTimer = Timer.scheduledTimer(withTimeInterval: self.fishingLineUpdateHeightInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                await self?.increaseFishingLineHeight()
            }
        }
    }
    
    func increaseFishingLineHeight() async {
        guard self.fishingLineHeight <= self.fishingLineMaxHeight else {
            await self.decreaseFishingLineHeight()
            return
        }
        self.fishingLineHeight += 1.0
    }
    
    func decreaseFishingLineHeight() async {
        self.fishingLineIncreaseHeightTimer?.invalidate()

        self.fishingLineDecreaseHeightTimer = Timer.scheduledTimer(withTimeInterval: self.fishingLineUpdateHeightInterval, repeats: true) { _ in
            Task { @MainActor [weak self] in
                guard let self, self.fishingLineHeight > 0.0 else {
                    self?.fishingLineDecreaseHeightTimer?.invalidate()
                    return
                }
                
                self.fishingLineHeight -= 1
            }
        }
    }
    
    func resetCatching() {
        self.fishingLineHeight = 0.0
        self.fishingLineIncreaseHeightTimer?.invalidate()
        self.fishingLineIncreaseHeightTimer = nil
        self.fishingLineDecreaseHeightTimer?.invalidate()
        self.fishingLineDecreaseHeightTimer = nil
    }
    
    func getXPosition(for width: CGFloat) -> CGFloat {
        var value = (width * (self.crownValue + 1) / 2)
        
        var needUpdateScaleEffect: Bool = true
        if value < self.boatImageWidth / 2 {
            value = self.boatImageWidth / 2
            needUpdateScaleEffect = false
        } else if value > width - self.boatImageWidth / 2 {
            value = width - self.boatImageWidth / 2
            needUpdateScaleEffect = false
        }
        
        if needUpdateScaleEffect {
            self.updateScaleEffect(for: value)
        }
        
        return value
    }
    
    func getFishLineXPosition(for width: CGFloat) -> CGFloat {
        var value = (width * (self.crownValue + 1) / 2)
        
        if value < self.boatImageWidth / 2 {
            value = self.boatImageWidth / 2
        } else if value > width - self.boatImageWidth / 2 {
            value = width - self.boatImageWidth / 2
        }
        
        let boartWidth = (self.boatImageWidth / 2) * 0.65
        let direction = self.isFacingLeft ? -1.0 : 1.0
        return value + (boartWidth * direction)
    }
    
    func getFishLineYPosition(for width: CGFloat) -> CGFloat {
        return 1
    }
    
    private func updateScaleEffect(for value: CGFloat) {
        guard value != self.previousCrownValue else { return }
        self.isFacingLeft = value < self.previousCrownValue ? true : false
        self.previousCrownValue = value
    }
    
    func getFishngLineHeight() -> CGFloat {
        let value = self.fishingLineMaxY - self.fishingLineMinY
        print("getFishngLineHeight: \(value)")
        return value
    }
}

extension BoatViewModel: SeaBoundigBoxDelegate {
    func boxDidChangeWith(box: FishBoundingBox) {
        self.boundingBox = box
        self.fishingLineMinY = box.minY + self.offsetY - 2.0
        self.fishingLineMaxY = box.maxY + Helper.fishHeight - self.offsetY
        self.fishingLineMaxHeight = self.fishingLineMaxY - self.fishingLineMinY
    }
}
