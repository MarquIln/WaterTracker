//
//  ContentView.swift
//  WaterTracker Watch App
//
//  Created by Marcos on 16/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var days: [WaterDay]

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Text("💧 \(today.amount) ml")
                    .font(.headline)

                ProgressView(value: min(Double(today.amount) / 2000.0, 1.0))
                    .tint(.blue)

                HStack {
                    Button("+200") { add(200) }
                    Button("+300") { add(300) }
                    Button("+500") { add(500) }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.mini)

                NavigationLink("Histórico", destination: DayListView())
                    .padding(.top, 8)
            }
            .padding()
            .navigationTitle("Hidratação")
        }
    }
    
    private var today: WaterDay {
        if let existing = days.first(where: { $0.dateKey == WaterDay.key(for: .now) }) {
            return existing
        } else {
            let new = WaterDay(date: .now, amount: 0)
            context.insert(new)
            try? context.save()
            return new
        }
    }

    private func add(_ amount: Int) {
        let today = today
        today.amount = max(0, today.amount + amount)
        try? context.save()
    }
}
