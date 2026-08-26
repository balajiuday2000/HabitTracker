//
//  StatsView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/26/26.
//

import Foundation
import SwiftUI
import Charts

struct StatsView: View {
    var viewModel: HabitsViewModel
    
    private var completedTasks: Int {
        viewModel.habits.filter({ $0.isCompleted == true }).count
    }
    
    private var pendingTasks: Int {
        viewModel.habits.filter({ $0.isCompleted == false }).count
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Chart {
                    BarMark(
                        x: .value("Status", "Completed"),
                        y: .value("Count", completedTasks)
                    )
                    .foregroundStyle(.green)
                    
                    BarMark(
                        x: .value("Status", "Pending"),
                        y: .value("Count", pendingTasks)
                    )
                }
                .frame(height: 250)
                .padding()
                
                Text("\(completedTasks) of \(viewModel.habits.count) habits completed today")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Stats")
        }
    }
}

