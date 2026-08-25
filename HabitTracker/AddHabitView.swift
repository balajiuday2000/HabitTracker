//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation
import Combine
import SwiftUI

struct AddHabitView: View {
    @State private var title: String = ""
    @State private var subtitle: String = ""
    @Environment(\.dismiss) private var dismiss
    var onSave: (Habit) -> Void
    private var isSaveDisabled: Bool {
        title.trimmingCharacters(in: .whitespaces).isEmpty &&
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
                        onSave(Habit(title: title, subtitle: subtitle))
                        dismiss()
                    }
                    .disabled(isSaveDisabled)
                }
            }
        }
    }
}



