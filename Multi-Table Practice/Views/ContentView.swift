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
    @State private var questions = [Question]()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Choose table scale")) {
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
                    
                    // Generate all the questions
                    self.generateQuestions()
                    
                    print("xxx")
                    
                }) {
                    Text("Let's go!")
                }
                
            }
            .navigationBarTitle("Settings")
        }
    }
    
    func generateQuestions() {
        var counter = 0
        let rowCount = Int(row) ?? 1
        let colCount = Int(col) ?? 1
        
        for i in 1 ... rowCount {
            for j in 1 ... colCount {
                questions.append(Question(questionText: "\(i) x \(j)", answer: i * j))
                print(questions.last!)
                counter += 1
            }
        }
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