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
            TabView {
                // First View
                VStack(alignment: .center) {
                    Text("Today").font(.headline)
                    ProgressRingView(progress: viewModel.habits.isEmpty ? 0 : Double(completedTasks) / Double(viewModel.habits.count))
                        .padding(.vertical)
                }

                // Second View
                VStack {
                    Text("This week").font(.headline)
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
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .navigationTitle("Stats")
        }
    }
}

