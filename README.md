# HabitTracker

A polished SwiftUI habit tracking app.

## Features

- **Habits list**: View all your habits as custom-styled cards and animations.
- **Add habits**: Create new habits via a sheet-presented form.
- **Delete habits** with a dedicated trash button.
- **Reorder habits** via native long-press drag-and-drop.
- **Stats tab**: View your progress for the day and the week by comparing completed vs. remaining habits.
- **Local notifications** for per-habit daily reminders.

```
HabitTracker/
├── HabitTrackerApp.swift        
├── Models/
│   └── Habit.swift              
├── ViewModels/
│   ├── HabitsViewModel.swift
│   └── AddHabitViewModel.swift     
├── Views/
│   ├── RootView.swift       
│   ├── HabitsListView.swift       
│   ├── HabitCardView.swift       
│   ├── AddHabitView.swift        
│   ├── StatsView.swift
│   ├── DailyProgressView.swift
│   └── WeeklyProgressView.swift          
```
