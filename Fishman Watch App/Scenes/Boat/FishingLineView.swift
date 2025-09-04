//
//  FishingLineView.swift
//  Fishman Watch App
//
//  Created by Раис Аглиуллов on 04.09.2025.
//

import SwiftUI

struct FishingLineView: View {
    let topY: CGFloat
    let bottomY: CGFloat
    let xPosition: CGFloat
    let color: Color
    let lineWidth: CGFloat
    
    @State private var phase: CGFloat = 0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let offset = sin(time * 3) * 4 // амплитуда изгиба
            
            Path { path in
                let top = CGPoint(x: xPosition, y: topY)
                let bottom = CGPoint(x: xPosition, y: bottomY)
                let control = CGPoint(
                    x: xPosition + offset,
                    y: (topY + bottomY) / 2.0
                )
                
                path.move(to: top)
                path.addQuadCurve(to: bottom, control: control)
            }
            .stroke(color, lineWidth: lineWidth)
        }
    }
}
