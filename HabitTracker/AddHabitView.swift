//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation
import Combine
import SwiftUI
import UserNotifications

struct AddHabitView: View {
    @State private var title: String = ""
    @State private var subtitle: String = ""
    @State private var reminderTime: Date = Date()
    @State private var isReminderEnabled: Bool = false
    @Environment(\.dismiss) private var dismiss
    var onSave: (Habit) -> Void
    private var isSaveDisabled: Bool {
        title.trimmingCharacters(in: .whitespaces).isEmpty ||
        subtitle.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Set title") {
                    TextField("Enter title here", text: $title)
                }
                Section("Set subtitle") {
                    TextField("Enter subtitle here", text: $subtitle)
                }
                Toggle("Set a daily reminder?", isOn: $isReminderEnabled)
                if isReminderEnabled {
                    DatePicker("Select time:", selection: $reminderTime, displayedComponents: .hourAndMinute)
                }
            }
            .navigationTitle("Add a habit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Request permission for notifications
                        if isReminderEnabled {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                                _, _ in
                            }
                        }
                        // Save habit
                        onSave(Habit(
                            title: title,
                            subtitle: subtitle,
                            reminderTime: isReminderEnabled ? reminderTime : nil
                        ))
                        dismiss()
                    }
                    .disabled(isSaveDisabled)
                }
            }
        }
    }
}



