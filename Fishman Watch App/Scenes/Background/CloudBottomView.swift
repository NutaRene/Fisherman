//
//  CloudView.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 10.08.2025.
//

import SwiftUI

struct CloudView: View {
    private let cloudSpeed: Double = 60.0
    private let cloudOriginalSize = CGSize(width: 1792.0, height: 326.0)
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 120.0)) { timeline in
            GeometryReader { geo in
                let cloudOriginalSize = CGSize(width: 1792, height: 326) // реальные размеры картинки
                let cloudHeight = geo.size.height
                let scaledWidth = cloudOriginalSize.width * (cloudHeight / cloudOriginalSize.height)
                let totalWidth = scaledWidth * 3
                
                let time = timeline.date.timeIntervalSinceReferenceDate
                let progress = (time.truncatingRemainder(dividingBy: cloudSpeed)) / cloudSpeed
                let offsetX = -CGFloat(progress) * scaledWidth
                
                HStack(spacing: 0) {
                    Image("cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: cloudHeight)
                        .clipped()
                    
                    Image("cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: cloudHeight)
                        .clipped()
                    
                    Image("cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: cloudHeight)
                        .clipped()
                        .scaleEffect(x: -1, y: 1)
                    
                }
                .frame(width: totalWidth, height: cloudHeight, alignment: .leading)
                .offset(x: offsetX)
                .clipped()
            }
            .frame(height: Helper.watchScreenBounds.height * 0.35)
        }
    }
}
