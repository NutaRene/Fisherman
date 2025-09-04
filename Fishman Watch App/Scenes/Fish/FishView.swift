//
//  FishView.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import SwiftUI

struct FishView: View {
    @State private var viewModel: FishViewModel
    
    init(viewModel: FishViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        self.viewModel.getImage()
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40, alignment: .center)

    }
}
