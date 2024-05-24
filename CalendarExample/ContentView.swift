//
//  ContentView.swift
//  CalendarExample
//
//  Created by Kevin on 5/23/24.
//

import SwiftUI
import CalendarUI

struct ContentView: View {
    @State var selectedDate: Date? = Date()

    var body: some View {
        CalendarView(
            selectedDate: $selectedDate,
            colorSelected: Color.red
        )
    }
}
