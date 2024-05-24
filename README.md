
# CalendarView Project

## Overview
The CalendarView project is a Swift package containing a SwiftUI component for displaying a calendar grid. It allows users to navigate between months and select dates within the calendar.

## Components
The project consists of the following main components:

### CalendarView
- `CalendarView` is a SwiftUI `View` that displays a grid of dates representing a calendar month.
- Users can navigate between months using navigation buttons.
- Dates within the calendar can be selected by tapping on them.
<img src="https://raw.githubusercontent.com/codedeman/Calendar/main/ImageDemo/Simulator%20Screenshot%20-%20iPhone%2015%20-%202024-05-24%20at%2012.29.03.png" alt="CalendarView Example" width="600"/>

### Helper Functions
- `getCalendarGrid(for date: Date) -> [[Date?]]`: This function generates a grid of dates for a given month, starting from the provided date.

## Usage
To use the `CalendarView` component in your SwiftUI project:
1. Import the `CalendarUI` module.
2. Initialize a `Binding<Date?>` variable to hold the selected date.
3. Add a `CalendarView` instance to your SwiftUI view hierarchy, passing the `Binding<Date?>` variable to it.

## Checklist ✅
- [X] Initialize a `Binding<Date?>` variable in your SwiftUI view.
- [X] Add a `CalendarView` instance to your view hierarchy.
- [X] Implement navigation buttons to switch between months.
- [X] Ensure dates can be selected and the selected date is highlighted.
- [X] Write unit tests for the `getCalendarGrid(for:)` function.
- [X] Verify the grid layout for different months, including edge cases like leap years.
- [X] Document the usage and functionality of the `CalendarView` component.
- [X] Add the `CalendarView` package as a dependency in your project.


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
