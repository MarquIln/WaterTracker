//
//  DayListView.swift
//  WaterTracker Watch App
//
//  Created by Marcos on 16/10/25.
//

import SwiftUI
import SwiftData

struct DayListView: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: \WaterDay.date, order: .reverse) private var days: [WaterDay]
    
    @State private var showingAddDay = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(days) { day in
                    NavigationLink(value: day) {
                        HStack {
                            Text(day.date.formatted(date: .abbreviated, time: .omitted))
                            Spacer()
                            Text("\(day.amount) ml")
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .onDelete(perform: deleteDays)
            }
            .navigationTitle("Hidratação 💧")
            .navigationDestination(for: WaterDay.self) { day in
                EditDayView(day: day)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("+") { showingAddDay = true }
                }
            }
            .sheet(isPresented: $showingAddDay) {
                AddDayView(isPresented: $showingAddDay)
            }
        }
    }

    private func deleteDays(at offsets: IndexSet) {
        for index in offsets {
            context.delete(days[index])
        }
        try? context.save()
    }
}
