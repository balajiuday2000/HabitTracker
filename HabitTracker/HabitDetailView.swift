//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation
import Combine
import SwiftUI

struct HabitDetailView: View {
    let title: String
    let subtitle: String
    var body: some View {
        Text("\(title)")
        Text("\(subtitle)")
    }
}

