//
//  CalendarCustomizeConfig.swift
//  
//
//  Created by Kevin on 6/21/24.
//

import Foundation

public struct CalendarCustomizeConfig {
    var width: CGFloat = 0
    var height: CGFloat = 0
    var calendarType: CalendarCustomizeType
    var cornerRadius: CGFloat = 0

    public init(width: CGFloat,
         height: CGFloat,
         calendarType: CalendarCustomizeType,
         cornerRadius: CGFloat = 15
    ) {
        self.width = width
        self.height = height
        self.calendarType = calendarType
        self.cornerRadius = cornerRadius
    }


}

public enum CalendarCustomizeType {
    case normal
    case multiple
}
