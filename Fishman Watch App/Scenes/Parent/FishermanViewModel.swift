//
//  FishermanViewModel.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import SwiftUI

@Observable
final class FishermanViewModel {
    let boatViewModel: BoatViewModel
    let seaViewModel: SeaBottomViewModel
    
    private(set) var isCatchInProgress: Bool = false
    
    private var crownValue: Double {
        return boatViewModel.crownValue
    }
    
    init() {
        let boatViewModel = BoatViewModel()
        self.boatViewModel = boatViewModel
        self.seaViewModel = SeaBottomViewModel(boundingBoxDelegate: boatViewModel)
    }
    
    func updateCatchState(_ value: Bool) {
        self.boatViewModel.updateCatchState(value: value)
        self.isCatchInProgress = value
    }
}


