//
//  WaterDay.swift
//  DiceRoll
//
//  Created by Marcos on 16/10/25.
//

import Foundation
import SwiftData

@Model
final class WaterDay {
    var id: UUID = UUID()
    var dateKey: String
    var date: Date
    var amount: Int

    init(date: Date = .now, amount: Int = 0) {
        self.date = date
        self.amount = amount
        self.dateKey = Self.key(for: date)
    }

    static func key(for date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: date)
    }
}
