//
//  ContentView.swift
//  Multi-Table Practice
//
//  Created by Nate Lee on 7/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var row: String = "10"
    @State private var col: String = "10"
    @State private var questionsCount = 5
    var questions = [Question]()
    
    var body: some View {
        Form {
            Section(header: Text("Choose scale")) {
                TextField("Rows", text: $row)
                    .keyboardType(.numberPad)
                TextField("Cols", text: $col)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Chosen table")) {
                // A little attention on plural detail
                Text("\(row == "" ? "0" : row) \(Int(row) ?? 0 > 1 ? "Rows" : "Row") x \(col == "" ? "0" : col) \(Int(col) ?? 0 > 1 ? "Columns" : "Column")")
            }
            
            Section(header: Text("How many questions do you want?")) {
                Stepper(value: $questionsCount, in: 5 ... 20, step: 5) {
                    Text("\(questionsCount)")
                }
            }
            
            Button(action: {
                // Dismiss keyboard
                self.hideKeyboard()
                
            }) {
                Text("Let's go!")
            }
        }
    }
    
    func generateQuestions() {
        
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
