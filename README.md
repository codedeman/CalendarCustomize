
# CalendarCustomize Project

## Overview
The CalendarCustomize project is a Swift package that provides a versatile SwiftUI component for displaying a calendar grid, including a single column layout option. This component allows seamless navigation between months and enables users to select dates, enhancing SwiftUI applications with robust calendar functionalities and flexible UI customization.

## Components
The project consists of the following main components:

### CalendarView
- `CalendarView` is a SwiftUI `View` that displays a grid of dates representing a calendar month.
- Users can navigate between months using navigation buttons.
- Dates within the calendar can be selected by tapping on them.

![Demo](https://raw.githubusercontent.com/codedeman/CalendarCustomize/main/ImageDemo/Simulator%20Screen%20Recording%20-%20iPhone%2015%20-%202024-06-21%20at%2013.49.24.gif)


### Helper Functions
- `getCalendarGrid(for date: Date) -> [[Date?]]`: This function generates a grid of dates for a given month, starting from the provided date.

## Usage
To use the `CalendarCustomize` component in your SwiftUI project:
1. Import the `CalendarCustomize` module.
2. Initialize a `Binding<Date?>` variable to hold the selected date.
3. Add a `CalendarView` instance to your SwiftUI view hierarchy, passing the `Binding<Date?>` variable to it.

## Checklist ✅
- [X] Provide single column calendar and basic calendar.
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
import CalendarCustomize

struct ContentView: View {
    @State private var selectedDate: Date?

    var body: some View {
        CalendarViewBasic(selectedDate: $selectedDate)
    }
}
```

```swift
import SwiftUI
import CalendarCustomize

struct ContentView: View {
    @State private var selectedDate: Date?

    var body: some View {
        CalendarSingleColumnView(selectedDate: $selectedDate)
    }
}
```


