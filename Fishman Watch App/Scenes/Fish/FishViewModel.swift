//
//  FishViewModel.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import SwiftUI

@Observable
final class FishViewModel: Identifiable {
    var fish: Fish
    
    init(fish: Fish) {
        self.fish = fish
    }

    func getImage() -> Image {
        let image = Image(self.fish.imageName)
        return image
    }
}
