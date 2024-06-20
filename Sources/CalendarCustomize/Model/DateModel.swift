//
//  DateModel.swift
//  
//
//  Created by Kevin on 6/20/24.
//

import Foundation

struct DateModel: Identifiable,Equatable {
    let id: UUID = UUID()
    let date: Date?
}
