//
//  ContentView.swift
//  Demo
//
//  Created by Kevin on 6/13/24.
//

import SwiftUI
import CalendarCustomize

struct ContentView: View {
    @State public var selectedDate: Date?

    var body: some View {
        VStack {
            CalendarSingleColumnView(selectedDate: $selectedDate)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
