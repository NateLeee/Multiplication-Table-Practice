//
//  ContentView.swift
//  Multi-Table Practice
//
//  Created by Nate Lee on 7/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var row: String = "9"
    @State private var col: String = "9"
    @State private var questionsCount = 5
    @State private var questions = [Question]()
    @State private var gotoGameView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // A little attention on plural detail
                    Section(header: Text("Choose table scale, now \(row == "" ? "0" : row) \(Int(row) ?? 0 > 1 ? "rows" : "row") x \(col == "" ? "0" : col) \(Int(col) ?? 0 > 1 ? "columns" : "column") chosen")) {
                        TextField("Rows", text: $row)
                            .keyboardType(.numberPad)
                        TextField("Cols", text: $col)
                            .keyboardType(.numberPad)
                    }
                    
                    Section(header: Text("How many questions do you want?")) {
                        Stepper(value: $questionsCount, in: 5 ... 25, step: 5) {
                            Text("\(questionsCount > 20 ? "All" : String(questionsCount))")
                        }
                    }
                    
                    Button(action: {
                        // Dismiss keyboard
                        self.hideKeyboard()
                        
                        // Generate all the questions
                        self.generateQuestions()
                        
                        print("xxx")
                        self.gotoGameView = true
                        
                    }) {
                        Text("Let's go!")
                    }
                }
                
                // NavigationLink now is invisible!
                NavigationLink(destination: GameView(questions: questions, questionsCount: questionsCount), isActive: $gotoGameView) {
                    EmptyView()
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
                // print(questions.last!)
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
