//
//  GameView.swift
//  Multi-Table Practice
//
//  Created by Nate Lee on 7/11/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct GameView: View {
    var questions: [Question]
    var questionsCount: Int
    
    @State private var questionIndex = 0
    @State private var score = 0
    @State private var showingAlert = false
    
    var body: some View {
        // print(questions)
        
        return VStack {
            Text("\(questions[questionIndex].questionText)")
                .padding()
            
            ForEach(0 ..< 3) { i in
                Button(action: {
                    // Simple logic for now. Maybe extract to a func later.
                    if (i == 0) {
                        self.score += 1
                    }
                    
                    self.questionIndex += 1
                    
                    if (self.questionIndex >= self.questionsCount) {
                        self.questionIndex = 0 // reset index.
                        self.showingAlert = true
                    }
                    
                }) {
                    Text("\(self.questions[self.questionIndex].answer + i)")
                }
                .padding()
                
            }
            
            Text("Current Score: \(score)")
            
            Spacer()
        }
        .alert(isPresented: $showingAlert) { () -> Alert in
            Alert(title: Text("Game Over"), message: Text("You scored \(score) out of \(questionsCount)!"), dismissButton: .default(Text("Restart"), action: {
                // TODO: - Go back to the first view
            }))
        }
    }
}

