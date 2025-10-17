//
//  EditDayView.swift
//  DiceRoll
//
//  Created by Marcos on 16/10/25.
//

import SwiftUI
import SwiftData

struct EditDayView: View {
    @Environment(\.modelContext) private var context
    @Bindable var day: WaterDay

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

            Slider(value: Binding(
                get: { Double(day.amount) },
                set: { day.amount = Int($0); try? context.save() }
            ), in: 0...5000, step: 50)

            Spacer()
        }
        .padding()
        .navigationTitle("Editar Dia")
    }

    private func adjust(_ value: Int) {
        day.amount = max(0, day.amount + value)
        try? context.save()
    }
}
