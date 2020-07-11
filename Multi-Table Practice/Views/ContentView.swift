//
//  ContentView.swift
//  Multi-Table Practice
//
//  Created by Nate Lee on 7/10/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    
    @State private var row: String = "9"
    @State private var col: String = "9"
    @State private var questionsCount = 5
    @State private var allGeneratedQuestions = [Question]()
    @State private var chosenQuestions = [Question]()
    
    var body: some View {
        Group {
            if (self.settings.showingSettings) {
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
                            
                            
                            self.settings.showingSettings = false
                            
                        }) {
                            Text("Let's GAME!")
                        }
                    }
                }
                
            } else {
                GameView(questions: chosenQuestions, questionsCount: questionsCount)
                
            }
        }
    }
    
    
    func generateQuestions() {
        let rowCount = Int(row) ?? 1
        let colCount = Int(col) ?? 1
        
        for i in 1 ... rowCount {
            for j in 1 ... colCount {
                allGeneratedQuestions.append(
                    Question(
                        questionText: "\(i) x \(j)",
                        answer: i * j,
                        possibleOptions: [i * j, (i - 1) * (j + 1), (i + 1) * (j - 1)].shuffled()
                ))
            }
        }
        
        // Pick out random questions
        let shuffledQuestions = allGeneratedQuestions.shuffled()
        
        if questionsCount > 20 {
            chosenQuestions = shuffledQuestions
            questionsCount = rowCount * colCount // Otherwise, it would be 25!
        } else {
            for i in 0 ..< questionsCount {
                chosenQuestions.append(shuffledQuestions[i])
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
