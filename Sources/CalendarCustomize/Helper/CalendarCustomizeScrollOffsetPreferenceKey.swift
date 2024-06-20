//
//  ScrollOffsetPreferenceKey.swift
//  
//
//  Created by Kevin on 6/20/24.
//

import SwiftUI

struct CalendarCustomizeScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0

    static func reduce(
        value: inout CGFloat,
        nextValue: () -> CGFloat
    ) {
        value = nextValue()
    }
}
