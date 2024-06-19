//
//  ContentView.swift
//  WeSplit(100daysOfSwift)
//
//  Created by Wolf on 18.06.2024.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = Array(0...100)
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
            let tipSelection = Double(tipPercentage)

            let tipValue = checkAmount / 100 * tipSelection
            let grandTotal = checkAmount + tipValue
            let amountPerPerson = grandTotal / peopleCount

            return amountPerPerson
    }
    var total: Double {
        let peopleCount = Double(numberOfPeople + 2)
            let tipSelection = Double(tipPercentage)

            let tipValue = checkAmount / 100 * tipSelection
            let grandTotal = checkAmount + tipValue

            return grandTotal
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Sum for person") {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                    }
                Section("Sum for all") {
                        Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                    }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
