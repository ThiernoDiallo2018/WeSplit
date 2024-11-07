//
//  ContentView.swift
//  WeSplit
//
//  Created by Thierno Diallo on 10/29/24.
//
// Views are just a function of their state

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [15, 20, 25, 30, 35, 0]
    
    var totalBeforeSplit: Double {
        
        let tipSelection = Double(tipPercentage) / 100
        let tipValue = checkAmount * tipSelection
        
        let total = checkAmount + tipValue
        
        return total
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage) / 100
        let tipValue = checkAmount * tipSelection
        
        let total = tipValue + checkAmount
        let perPerson = total / peopleCount
        
        return perPerson
    }
 
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check Amount") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Numeber of People", selection: $numberOfPeople) {
                        ForEach(0..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Percentage") {
                    Text("How much do you want to tip?")
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                
                    
                }
                
                Section("Check Value + Tip") {
                    Text(totalBeforeSplit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ))
                }
            }.navigationTitle("WeSplit")
             .navigationBarTitleDisplayMode(.inline)
             .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        

        }
    }
}

#Preview {
    ContentView()
}
