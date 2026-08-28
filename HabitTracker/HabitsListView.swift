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
    @State var showCongrats  = false
    
    private var allCompleted: Bool {
        !viewModel.habits.isEmpty && viewModel.habits.allSatisfy { $0.isCompleted }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                if !showCongrats {
                    // List View
                    List {
                        ForEach(viewModel.habits) { habit in
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
                } else {
                    // To show when all tasks get completed
                    Text("Woohoo! You're all done!")
                        .font(.system(size: 36, weight: .bold))
                        .multilineTextAlignment(.center)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .onChange(of: allCompleted) { _, newValue in
                if newValue {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showCongrats = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showCongrats = false
                        }
                    }
                }
                
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("addHabitButton")
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
