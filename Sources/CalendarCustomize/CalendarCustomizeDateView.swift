//
//  DateView.swift
//  
//
//  Created by Kevin on 6/14/24.
//

import SwiftUI

struct CalendarCustomizeDateView: View {
    let date: Date
    let isSelected: Bool
    let colorSelected: Color
    let colorUnSelected: Color
    let action: () -> Void

    var body: some View {
        VStack {
            Text(CalendarCustomizeHelper.weekdaySymbol(for: date))
                .font(.caption)
                .foregroundColor(.black)
            Text(CalendarCustomizeHelper.dateDisplayText(for: date))
                .padding(.horizontal)
        }
        .frame(height: 70)
        .foregroundColor(isSelected ? .white : .black)
        .background(isSelected ? colorSelected : colorUnSelected)
        .cornerRadius(15)
        .onTapGesture(perform: action)
    }
}
