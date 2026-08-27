//
//  ProgressRingView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/27/26.
//

import Foundation
import SwiftUI

struct ProgressRingView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            // Background track
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)

            // Foreground progress arc
            RingShape(progress: progress)
                .stroke(
                    Color.green,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .animation(.easeInOut(duration: 0.6), value: progress)

            VStack(spacing: 4) {
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 36, weight: .bold))
                Text("Completed")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 280, height: 280)
    }
}


struct RingShape: Shape {
    var progress: Double
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.height, rect.width) / 2
        
        path.addArc(
            center: center,
            radius: radius,
            startAngle: .degrees(-90),
            endAngle: .degrees(-90 + (360 * progress)),
            clockwise: false
        )

        return path
    }
    
    
}
