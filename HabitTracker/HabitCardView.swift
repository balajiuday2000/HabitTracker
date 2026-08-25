//
//  HabitCardView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation
import SwiftUI

struct HabitCardView: View {
    var habit: Habit
    var onToggle: () -> Void
    var onDelete: () -> Void
    
    @State private var hasAppeared = false

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(habit.isCompleted ? Color(uiColor: .green): Color(uiColor: .lightGray))
                .animation(.easeInOut(duration: 0.3), value: habit.isCompleted)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(habit.title).font(.headline)
                    Text(habit.subtitle).font(.subheadline)
                }
                Spacer()
                Button {
                    onToggle()
                } label: {
                    Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 26))
                        .foregroundStyle(.black)
                        .scaleEffect(habit.isCompleted ? 1.20 : 1.0)
                        .contentTransition(.symbolEffect(.replace))
                        .symbolEffect(.bounce, value: habit.isCompleted)
                }
                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        onDelete()
                    }
                } label: {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 26))
                        .foregroundStyle(.black)
                }
            }
            .padding(.all)
        }
        .padding(.horizontal)
        .scaleEffect(hasAppeared ? 1.0 : 1.3)
        .onAppear {
            withAnimation(.spring(response: 1.0, dampingFraction: 0.5)) {
                hasAppeared = true
            }
        }
    }
}

