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
    
    var body: some View {
        VStack {
            Text("\(questions[questionIndex].questionText)")
                .padding()
            
            ForEach(0 ..< 3) { i in
                Button(action: {
                    // Simple logic for now.
                    if (i == 0) {
                        self.score += 1
                    }
                    
                    self.questionIndex += 1
                    
                    if (self.questionIndex >= self.questionsCount) {
                        // Do more later
                        print("Game over!")
                        
                    }
                    
                }) {
                    Text("\(self.questions[self.questionIndex].answer + i)")
                }
                .padding()
                
            }
            
            Text("Current Score: \(score)")
            
            Spacer()
        }
    }
}

