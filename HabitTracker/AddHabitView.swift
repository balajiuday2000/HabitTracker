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
    @State var viewModel: AddHabitViewModel = AddHabitViewModel()
    @Environment(\.dismiss) private var dismiss
    var onSave: (Habit) -> Void
    private var isSaveDisabled: Bool {
        viewModel.title.trimmingCharacters(in: .whitespaces).isEmpty ||
        viewModel.subtitle.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Set title") {
                    TextField("Enter title here", text: $viewModel.title)
                        .accessibilityIdentifier("habitTitleTextField")
                }
                Section("Set subtitle") {
                    TextField("Enter subtitle here", text: $viewModel.subtitle)
                        .accessibilityIdentifier("habitSubtitleTextField")
                }
                Toggle("Set a daily reminder?", isOn: $viewModel.isReminderEnabled)
                if viewModel.isReminderEnabled {
                    DatePicker("Select time:", selection: $viewModel.reminderTime, displayedComponents: .hourAndMinute)
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
                        if viewModel.isReminderEnabled {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                                _, _ in
                            }
                        }
                        // Save habit
                        onSave(Habit(
                            title: viewModel.title,
                            subtitle: viewModel.subtitle,
                            reminderTime: viewModel.isReminderEnabled ? viewModel.reminderTime : nil
                        ))
                        dismiss()
                    }
                    .disabled(isSaveDisabled)
                    .accessibilityIdentifier("saveHabbitButton")
                }
            }
        }
    }
}
