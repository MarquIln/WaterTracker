//
//  AddDayView.swift
//  DiceRoll
//
//  Created by Marcos on 16/10/25.
//

import SwiftUI
import SwiftData

struct AddDayView: View {
    @Environment(\.modelContext) private var context
    @Binding var isPresented: Bool

    @State private var selectedDate = Date()
    @State private var amount = 0
    @State private var errorMessage: String?

    private var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let now = Date()
        let year = calendar.component(.year, from: now)
        let start = calendar.date(from: DateComponents(year: year)).map { calendar.startOfDay(for: $0) } ?? now
        return start...now
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Adicionar Dia 💧")
                .font(.headline)
                .padding(.top, 8)

            DatePicker(
                "",
                selection: $selectedDate,
                in: dateRange,
                displayedComponents: .date
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .tint(.blue)
            .frame(height: 100)

            VStack(spacing: 6) {
                Text("\(amount) ml")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .contentTransition(.numericText(value: Double(amount)))

                HStack(spacing: 30) {
                    Button {
                        amount = max(0, amount - 100)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 28))
                    }

                    Button {
                        amount += 100
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 28))
                    }
                }
                .buttonStyle(.plain)
                .foregroundStyle(.blue)
            }

            if let errorMessage {
                Text(errorMessage)
                    .font(.caption2)
                    .foregroundStyle(.red)
            }

            Spacer()

            Button("Salvar") {
                saveDay()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            .padding(.bottom, 8)
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }

    private func saveDay() {
        let newDay = WaterDay(date: selectedDate, amount: amount)
        context.insert(newDay)
        try? context.save()
        isPresented = false
    }
}
