//
//  ContentView.swift
//  Konvrtr
//
//  Created by Martin Lipták on 29/12/2023.
//

import SwiftUI

enum Unit : CaseIterable, Identifiable, CustomStringConvertible {
    case meters
    case kilometers
    case feet
    case yard
    case miles
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .meters:
            return "meters"
        case .kilometers:
            return "kilometers"
        case .feet:
            return "feet"
        case .yard:
            return "yards"
        case .miles:
            return "miles"
        }
    }
}

struct ContentView: View {
    
    @State private var inputAmount: Double? = nil
    @State private var inputUnit: Unit = .meters
    @State private var outputUnit: Unit = .feet
    
    private var result: Double {
        if inputAmount == nil {return 0}
        
        var valueInMilimeters: Double {
            switch inputUnit {
                case .meters:
                    return inputAmount! * 1_000
                case .kilometers:
                    return inputAmount! * 1_000_000
                case .feet:
                    return inputAmount! * 304.8
                case .yard:
                    return inputAmount! * 914.4
                case .miles:
                    return inputAmount! * 1_609_344
            }
        }
        
        var result: Double {
            switch outputUnit {
                case .meters:
                    return valueInMilimeters * 1_000
                case .kilometers:
                    return valueInMilimeters * 1_000_000
                case .feet:
                    return valueInMilimeters / 304.8
                case .yard:
                    return valueInMilimeters / 914.4
                case .miles:
                    return valueInMilimeters / 1_609_344
            }
        }
        
        return result
    }
    
    @FocusState private var inputAmountFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Convert lenth values") {
                    TextField("Amount", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputAmountFocused)
                    
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(Unit.allCases, id: \.id) {
                            Text($0.description)
                        }
                    }
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(Unit.allCases) {
                            Text($0.description)
                        }
                    }
                }
                Section ("Result") {
                    Text("\(result.formatted()) \(outputUnit.description)")
                }
            }
            .navigationTitle("Konvrt")
            .toolbar {
                if inputAmountFocused {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Done") {
                            inputAmountFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
