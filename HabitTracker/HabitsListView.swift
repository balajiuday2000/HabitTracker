//
//  ContentView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import SwiftUI

struct HabitsListView: View {
    var viewModel: HabitsViewModel
    @State var showingAddHabit = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.habits, id: \.id) { habit in
                    HabitCardView(habit: habit) {
                        viewModel.onToggle(habit: habit)
                    } onDelete: {
                        viewModel.delete(habit: habit)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            withAnimation(.easeOut(duration: 0.2)) {
                                viewModel.delete(habit: habit)
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
                .onMove(perform: viewModel.onOrderChanged)
            }
            .listStyle(.plain)
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
