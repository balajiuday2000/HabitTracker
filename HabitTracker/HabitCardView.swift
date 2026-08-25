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

    var body: some View {
        NavigationLink(value: habit) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(uiColor: .lightGray))
                VStack(alignment: .leading, spacing: 5) {
                    Text(habit.title).font(.headline)
                    Text(habit.subtitle).font(.subheadline)
                }
                .padding(.all)
            }
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
}

