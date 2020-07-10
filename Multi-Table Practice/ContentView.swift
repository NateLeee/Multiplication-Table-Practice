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
    
    
    var body: some View {
        Form {
            Section(header: Text("Choose scale")) {
                TextField("Rows", text: $row)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                TextField("Cols", text: $col)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
            }
            Text("Table: \(row) x \(col)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
