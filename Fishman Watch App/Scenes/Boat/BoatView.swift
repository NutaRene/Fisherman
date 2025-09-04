//
//  BoatView.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import SwiftUI

struct BoatView: View {
    @State private var viewModel: BoatViewModel
    
    init(viewModel: BoatViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { proxy in
            Image("fisherman")
                .resizable()
                .frame(width: self.viewModel.boatImageWidth, height: self.viewModel.boatImageWidth)
                .scaledToFit()
                .scaleEffect(x: self.viewModel.isFacingLeft ? 1 : -1, y: 1)
                .animation(.easeInOut(duration: 0.3), value: self.viewModel.isFacingLeft)
                .position(
                    x: self.viewModel.getXPosition(for: proxy.size.width),
                    y: self.viewModel.offsetY
                )
                .focusable(!self.viewModel.isCatching)
            
            if self.viewModel.isCatching {
                Rectangle().foregroundStyle(.red)
                    .frame(width: 3, height: self.viewModel.fishingLineHeight, alignment: .top)
                    .position(
                        x: self.viewModel.getFishLineXPosition(for: proxy.size.width),
                        y: self.viewModel.fishingLineMinY + (self.viewModel.fishingLineHeight / 2)
                    )
            }
        }
        .digitalCrownRotation($viewModel.crownValue, from: -1.0, through: 1.0, by: 0.002, sensitivity: .low, isContinuous: false)
    }
}
