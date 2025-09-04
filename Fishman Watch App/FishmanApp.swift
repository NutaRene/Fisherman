//
//  FishmanApp.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 03.08.2025.
//

import SwiftUI

@main
struct Fishman_Watch_AppApp: App {
    private let appViewModel = FishermanViewModel()
    
    var body: some Scene {
        WindowGroup {
            FishermanView(viewModel: self.appViewModel)
        }
    }
}
