//
//  ContentView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = HabitsViewModel()
    @State var showingAddHabit = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(viewModel.habits, id: \.id) { habit in
                        HabitCardView(habit: habit) {
                            viewModel.onToggle(habit: habit)
                        }
                    }
                }
            }
            .navigationDestination(for: Habit.self) { habit in
                HabitDetailView(title: habit.title, subtitle: habit.subtitle)
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset all") {
                        viewModel.resetAll()
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
