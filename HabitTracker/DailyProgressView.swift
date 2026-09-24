//
//  DailyProgressView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/27/26.
//

import Foundation
import SwiftUI

struct DailyProgressView: View {
    var habits: [Habit]

    private var completedTasks: Int {
        habits.filter({ $0.isCompleted == true }).count
    }

    private var pendingTasks: Int {
        habits.filter({ $0.isCompleted == false }).count
    }

    var progress: Double {
        habits.isEmpty ? 0 : Double(completedTasks) / Double(habits.count)
    }
    
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

            VStack(alignment: .center, spacing: 4) {
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 36, weight: .bold))
                Text("Completed")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 250, height: 250)
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
