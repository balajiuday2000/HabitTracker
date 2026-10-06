//
//  AddHabitViewModel.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 10/6/26.
//

import Foundation
import SwiftUI

@Observable
class AddHabitViewModel {
    var title: String = ""
    var subtitle: String = ""
    var reminderTime: Date = Date()
    var isReminderEnabled: Bool = false
}


