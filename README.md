
# CalendarView Project

## Overview
The CalendarView project is a Swift package containing a SwiftUI component for displaying a calendar grid. It allows users to navigate between months and select dates within the calendar.

## Components
The project consists of the following main components:

### CalendarView
- `CalendarView` is a SwiftUI `View` that displays a grid of dates representing a calendar month.
- Users can navigate between months using navigation buttons.
- Dates within the calendar can be selected by tapping on them.

### Helper Functions
- `getCalendarGrid(for date: Date) -> [[Date?]]`: This function generates a grid of dates for a given month, starting from the provided date.

## Usage
To use the `CalendarView` component in your SwiftUI project:
1. Import the `CalendarUI` module.
2. Initialize a `Binding<Date?>` variable to hold the selected date.
3. Add a `CalendarView` instance to your SwiftUI view hierarchy, passing the `Binding<Date?>` variable to it.

Example:
```swift
import SwiftUI
import CalendarUI

struct ContentView: View {
    @State private var selectedDate: Date?

    var body: some View {
        CalendarView(selectedDate: $selectedDate)
    }
}
