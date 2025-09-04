//
//  SeaBottomView.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import SwiftUI

struct SeaBottomView: View {
    @State private var viewModel: SeaBottomViewModel
    
    init(viewModel: SeaBottomViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                VStack(alignment: .center, spacing: .zero) {
                    Image("bgTop")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .onGeometryChange(for: CGSize.self) { geometry in
                            return geometry.size
                        } action: { newValue in
                            let frame = proxy.frame(in: .local)
                            let newFrame = CGRect(x: frame.minX, y: frame.minY + newValue.height, width: newValue.width, height: frame.height + newValue.height)
                            self.viewModel.setBounds(newFrame)
                        }
                    
                    Image("bgBottom")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
                .frame(height: Helper.watchScreenBounds.height * 0.65)
                
                ForEach(self.viewModel.fishModels) { model in
                    FishView(viewModel: model)
                        .scaleEffect(x:  model.fish.isLeftDirection ? -1 : 1, y: 1)
                        .position(model.fish.position)
                }
            }
            .onAppear {
                self.viewModel.fetchFishes()
            }
        }
    }
}
