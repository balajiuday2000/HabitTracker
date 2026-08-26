//
//  RootView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/26/26.
//

import Foundation
import SwiftUI

struct RootView: View {
    @State var habitsViewModel = HabitsViewModel()
    
    var body: some View {
        TabView {
            HabitsListView(viewModel: habitsViewModel)
                .tabItem { Label("Habits", systemImage: "list.bullet") }

            StatsView(viewModel: habitsViewModel)
                .tabItem { Label("Stats", systemImage: "chart.bar.fill") }
        }
    }
}
