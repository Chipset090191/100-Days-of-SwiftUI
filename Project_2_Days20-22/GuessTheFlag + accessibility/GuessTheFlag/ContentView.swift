//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Михаил Тихомиров on 08.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTilte = ""
    @State private var score = 0
    @State private var countOfquestions = 0
    @State private var finalAlert = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red:0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red:0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text ("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text (countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original) // that`s for rendering real color of flag despite the mode of screen
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])  // accessible code
                            // when you tap it it starts description
                            
                        }
                        
                    }
                }
                //-------------------------------Creating the frame of our VStack`s flags
                .frame(maxWidth: .infinity) // frame of our rectangle
                .padding(.vertical, 20)
                .background(.regularMaterial)  // shous upn our rectangle
                .clipShape(RoundedRectangle(cornerRadius: 20))
                //-------------------------------Finish creating the frame
                
                Spacer() // these spacers allow to put Score at the bottom
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                
            }
            .padding()
        }
        
        .alert(scoreTilte, isPresented:$showingScore) {
            if countOfquestions < 8{
                Button ("Continue") {
                    askQuestion()
                }
            }else {
                Button ("New Game") {
                    askQuestion()
                    score = 0
                    countOfquestions = 0
                }
            }
            
        } message: {
            Text ("Your score is \(score)!")
        }
        
    }
    
    func flagTapped(_ number:Int) {
        countOfquestions += 1
        
            if number == correctAnswer {
                if countOfquestions < 8 {
                    scoreTilte = "Correct"
                    score += 1
                }else {
                    scoreTilte = """
                                 The FINAL was right. Good game!
                                 Click "New Game" to start again!
                                 """
                    score += 1
                    
                }
            }else if countOfquestions < 8 {
                scoreTilte = "Wrong. This is \(countries[number]) flag!"
            }else {
                scoreTilte = """
                             The FINAL was wrong. it was \(countries[number]).
                             Click "New Game" to start again!
                             """
            }
                showingScore = true
            
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
        
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
