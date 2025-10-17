//
//  EditDayView.swift
//  WaterTracker Watch App
//
//  Created by Marcos on 16/10/25.
//

import SwiftData
import SwiftUI

struct EditDayView: View {
    @Environment(\.modelContext) private var context
    @Bindable var day: WaterDay

    @State private var sliderValue: Double = 0

    var body: some View {
        VStack(spacing: 16) {
            Text(day.date.formatted(date: .long, time: .omitted))
                .font(.headline)

            Text("\(day.amount) ml")
                .font(.largeTitle)
                .bold()

            HStack {
                Button("-100") { adjust(-100) }
                Button("+100") { adjust(100) }
            }
            .buttonStyle(.borderedProminent)

            Slider(value: $sliderValue, in: 0...5000, step: 50)
                .onChange(of: sliderValue) { _, newValue in
                    day.amount = Int(newValue)
                    try? context.save()
                }

            Spacer()
        }
        .onAppear { sliderValue = Double(day.amount) }
        .padding()
        .navigationTitle("Editar Dia")
    }

    private func adjust(_ value: Int) {
        day.amount = max(0, day.amount + value)
        try? context.save()
    }
}
