//
//  WeeklyProgressView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/28/26.
//

import Foundation
import SwiftUI
import Charts

struct WeeklyProgressView: View {
    var habits: [Habit]
    
    private var weeklyData: [(day: Date,count: Int)] {
        let calender = Calendar.current
        let today = calender.startOfDay(for: Date())

        // Last seven days
        let days = (0 ..< 7).reversed().map { offset in
            calender.date(byAdding: .day, value: -offset, to: today)!
        }

        return days.map { day in
            let count = habits.filter { habit in
                habit.streak.contains { calender.isDate($0, inSameDayAs: day) }
            }.count
            return (day, count)
        }
    }

    var body: some View {
        Chart(weeklyData, id: \.day) { entry in
            BarMark(
               x: .value("Day", entry.day, unit: .day),
               y: .value("Completed", entry.count)
            )
            .foregroundStyle(.green.gradient)
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
        .frame(height: 250)
        .padding()
    }
}

