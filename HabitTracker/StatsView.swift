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

    var body: some View {
        NavigationStack {
            TabView {
                // First View
                VStack(alignment: .center) {
                    Text("Today").font(.headline)
                    DailyProgressView(habits: viewModel.habits)
                        .padding(.vertical)
                }

                // Second View
                VStack {
                    Text("This week").font(.headline)
                    WeeklyProgressView(habits: viewModel.habits)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .navigationTitle("Stats")
        }
    }
}

