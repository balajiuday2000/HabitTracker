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

    var body: some View {
        NavigationLink(value: habit) {
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
                            .scaleEffect(habit.isCompleted ? 1.15 : 1.0)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.all)
            }
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
}

