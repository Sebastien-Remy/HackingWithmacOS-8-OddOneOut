//
//  ContentView.swift
//  OddOneOut
//
//  Created by Sebastien REMY on 24/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    static let gridSize = 10
    
    @State var images = ["elephant", "giraffe", "hippo", "monkey", "panda", "parrot", "penguin", "pig", "rabbit", "snake"]
    @State var layout = Array(repeating: "penguin", count: gridSize * gridSize)
    @State var currenLevel = 1
    @State var isGameOver = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Odd One Out")
                    .font(.system(size: 36, weight: .thin))
                    .fixedSize()
                ForEach(0..<Self.gridSize, id: \.self) { row in
                    HStack {
                        ForEach(0..<Self.gridSize, id: \.self) { column in
                            Button {
                                print("Clicked")
                            } label : {
                                Image(image(row, column))
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }
        }
    }
    
    func image(_ row: Int, _ column: Int) -> String {
        layout[row * Self.gridSize + column]
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
