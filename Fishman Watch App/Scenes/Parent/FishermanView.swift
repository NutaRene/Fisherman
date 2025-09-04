//
//  FishermanView.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 03.08.2025.
//

import SwiftUI

struct FishermanView: View {
    @State private var viewModel: FishermanViewModel
    
    init(viewModel: FishermanViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    VStack(spacing: 0) {
                        CloudView()
                        SeaBottomView(viewModel: self.viewModel.seaViewModel)
                    }
                    .ignoresSafeArea()
                    
                    BoatView(viewModel: self.viewModel.boatViewModel)
                    
                   // if !self.viewModel.isCatchInProgress {
                        self.getHookButtonView(for: proxy.size)
                    //}
                }
            }
            .toolbar {
                self.toolbarActionView
            }
        }
    }
    
    private func getHookButtonView(for size: CGSize) -> some View {
        Button {
            self.viewModel.updateCatchState(true)
        } label: {
            Image("HookButton")
                .resizable()
                .scaledToFit()
                .frame(width: Helper.hookButtonHeight, height: Helper.hookButtonHeight, alignment: .center)
        }
        .buttonStyle(.plain)
        .position(x: size.width / 2,  y: size.height + Helper.hookButtonHeight / 2)
    }
    
    @ToolbarContentBuilder
    private var toolbarActionView: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            HStack(alignment: .center, spacing: 16.0) {
                Button {
                    
                } label: {
                    Image("gear")
                        .resizable()
                        .scaledToFit()
                        .frame(width: Helper.toolbarButtonHeight, height: Helper.toolbarButtonHeight, alignment: .center)
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    Image("score")
                        .resizable()
                        .scaledToFit()
                        .frame(width: Helper.toolbarButtonHeight, height: Helper.toolbarButtonHeight, alignment: .center)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    FishermanView(viewModel: FishermanViewModel())
}
