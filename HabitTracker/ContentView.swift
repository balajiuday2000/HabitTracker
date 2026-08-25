//
//  ContentView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HabitsViewModel(habits: [])
    @State var showingAddHabit = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.habits, id: \.id) { habit in
                    Text(habit.title)
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView { habit in
                    viewModel.addHabit(habit)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
