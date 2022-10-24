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
                                processAnswer(at: row, column)
                            } label : {
                                Image(image(row, column))
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }
            .onAppear(perform: createLevel)
            .contextMenu {
                Button("Start new game") {
                    currenLevel = 1
                    createLevel()
                }
            }
            .opacity(isGameOver ? 0.2 : 1)
            
            if isGameOver {
                VStack {
                    Text("Game over!")
                        .font(.largeTitle)
                    Button("Play again") {
                        currenLevel = 1
                        isGameOver = false
                        createLevel()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .buttonStyle(.borderless)
                    .padding(20)
                    .background(.blue)
                    .clipShape(Capsule())
                }
            }
        }
    }
    
    func image(_ row: Int, _ column: Int) -> String {
        layout[row * Self.gridSize + column]
    }
    
    func generatinLayout(items: Int) {
        // Remove any existing layout
        layout.removeAll(keepingCapacity: true)
        
        // Randomize image order, and consider the first image to be the correct animal
        images.shuffle()
        layout.append(images[0])
        
        // Prepare to loop through the other animals
        var numUsed = 0
        var itemCount = 1
        
        for _ in 1..<items {
            // place the current animal images and add to the counter
            layout.append(images[itemCount])
            numUsed += 1
            
            // If we already placed two, move to the next animal image
            if (numUsed == 2) {
                numUsed = 0
                itemCount += 1
            }
            
            // if we placed all the animal iages, go back to index 1
            if (itemCount == images.count) {
                itemCount = 1
            }
        }
        
        // fill the raainder of our array with empty rectangles then shuffles the layout
        layout += Array(repeating: "empty", count: 100 - layout.count)
        layout.shuffle()
    }
    
    func createLevel() {
        let numberOfItems = [0, 5, 15, 25, 35, 49, 65, 81, 100]
        if currenLevel == numberOfItems.count {
            withAnimation {
                isGameOver = true
            }
        } else {
            generatinLayout(items: numberOfItems[currenLevel])
        }
    }
    
    func processAnswer(at row: Int, _ column: Int) {
        if image(row, column) == images [0] {
            // Correct answer
            currenLevel += 1
            createLevel()
        } else {
            // Wrong
            if currenLevel > 1 {
                currenLevel -= 1
            }
            createLevel()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
