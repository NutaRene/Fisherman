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
            
            let xPosition = self.viewModel.getFishLineXPosition(for: proxy.size.width)
            let lineTopY = self.viewModel.fishingLineMinY
            let lineBottomY = self.viewModel.fishingLineMinY + self.viewModel.fishingLineHeight
            
            if self.viewModel.isCatching {
                FishingLineView(
                    topY: lineTopY,
                    bottomY: lineBottomY,
                    xPosition: xPosition,
                    color: Helper.fishingLineColor,
                    lineWidth: 1
                )
            }
            Image("Hook")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15, alignment: .center)
                .position(x: xPosition + 2, y: lineBottomY + 4)
        }
        .digitalCrownRotation($viewModel.crownValue, from: -1.0, through: 1.0, by: 0.002, sensitivity: .low, isContinuous: false)
    }
}
