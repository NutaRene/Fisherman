//
//  SeaBottomViewModel.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import Foundation

import SwiftUI

@MainActor
@Observable
final class SeaBottomViewModel {
    private(set) var fishModels: [FishViewModel] = []
    
    private var updateXPositionTimer: Timer?
    private var updateYPositionTimer: Timer?
    private var lastTimestampUpdatedXPositon: TimeInterval = CFAbsoluteTimeGetCurrent()
    
    private(set) var originBoundingBox: CGRect = .zero
    private(set) var boundingBox: FishBoundingBox = FishBoundingBox()

    private let updateXPositionInterval: TimeInterval = 1.0 / 60.0
    private let updateYPositionInterval: TimeInterval = 3.0
    private var lastUpdatedYpositionFish: FishViewModel?
            
    private weak var boundingBoxDelegate: SeaBoundigBoxDelegate?
    
    init(boundingBoxDelegate: SeaBoundigBoxDelegate) {
        self.boundingBoxDelegate = boundingBoxDelegate
        self.startFishMovement()
    }
    
    deinit {
        // stopFishMovement()
    }
    
    func setBounds(_ rect: CGRect) {
        self.originBoundingBox = rect
        let minX = rect.origin.x - Helper.fishHeight
        let maxX = rect.width - Helper.fishHeight / 2
        let minY = rect.minY + Helper.fishHeight / 4
        let maxY = rect.maxY - Helper.fishHeight
        self.boundingBox = FishBoundingBox(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
        self.boundingBoxDelegate?.boxDidChangeWith(box: self.boundingBox)
    }
    
    func fetchFishes() {
        guard self.fishModels.isEmpty else { return }
        let names = Helper.nonPredatoryFishImageNames.prefix(7).compactMap({$0})
        
        var fishModels: [FishViewModel] = []
    
        for name in names {
            let fish = Fish(
                imageName: name, id: UUID(),
                type: .nonPredatory,
                isCatched: false,
                position: CGPoint(x: CGFloat.random(in: self.boundingBox.minX...self.boundingBox.maxX), y: CGFloat.random(in: self.boundingBox.minY...self.boundingBox.maxY)),
                isLeftDirection: Bool.random()
            )
            let model = FishViewModel(fish: fish)
            fishModels.append(model)
        }
        
        self.fishModels = fishModels
    }
}

//MARK - Movement timers
extension SeaBottomViewModel {
    func startFishMovement() {
        stopFishMovement()
        lastTimestampUpdatedXPositon = CFAbsoluteTimeGetCurrent()
        updateXPositionTimer = Timer.scheduledTimer(withTimeInterval: updateXPositionInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                await self?.updateXPosition()
            }
        }
        
        updateYPositionTimer = Timer.scheduledTimer(withTimeInterval: updateYPositionInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                await self?.updateYPosition()
            }
        }
        
        RunLoop.main.add(updateXPositionTimer!, forMode: .common)
        RunLoop.main.add(updateYPositionTimer!, forMode: .common)
    }
    
    func stopFishMovement() {
        updateXPositionTimer?.invalidate()
        updateXPositionTimer = nil
        updateYPositionTimer?.invalidate()
        updateYPositionTimer = nil
    }
    
    private func updateYPosition() async {
        guard !fishModels.isEmpty else { return }
        
        let randomIndex = Int.random(in: 0..<fishModels.count)
        guard let fishModel = self.fishModels[safe: randomIndex], fishModel.id != self.lastUpdatedYpositionFish?.id else { return }
        self.lastUpdatedYpositionFish = fishModel
        
        let currentYPosition = fishModel.fish.position.y
        
        let getRandomYPositon = { () -> CGFloat in
            return CGFloat.random(in: self.boundingBox.minY...self.boundingBox.maxY)
        }
        
        var newY: CGFloat
        var attempts = 0
        let maxAttempts = 20
        
        repeat {
            newY = getRandomYPositon()
            attempts += 1
        } while fishModels.contains(where: { $0.fish.position.y.isClose(to: newY, tolerance: 20) })
        && attempts < maxAttempts
        
        guard abs(newY - currentYPosition) <= 60, newY < self.boundingBox.maxY else { return }
        
        withAnimation(.interactiveSpring(duration: 3.0)) {
            fishModel.fish.position.y = newY
        }
    }
    
    private func updateXPosition() async {
        let now = CFAbsoluteTimeGetCurrent()
        let dt = max(0, now - lastTimestampUpdatedXPositon)
        self.lastTimestampUpdatedXPositon = now
        
        guard !self.fishModels.isEmpty else { return }
        
        for i in fishModels.indices {
            let vm = fishModels[i]
            var fish = vm.fish
            
            let randomDelta = CGFloat.random(in: 0.0...0.05)
            let value = fish.speed * CGFloat(dt * 60) + randomDelta
            let dx = fish.isLeftDirection ? -value : value
            fish.position.x += dx
            
            if fish.position.x <= self.boundingBox.minX {
                fish.position.x = self.boundingBox.minX
                fish.isLeftDirection = false
            } else if fish.position.x >= self.boundingBox.maxX {
                fish.position.x = self.boundingBox.maxX
                fish.isLeftDirection = true
            }
            
            vm.fish = fish
            self.fishModels[i] = vm
        }
    }
}
