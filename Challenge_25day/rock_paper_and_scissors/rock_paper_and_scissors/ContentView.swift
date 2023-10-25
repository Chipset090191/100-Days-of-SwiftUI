//
//  ContentView.swift
//  rock_paper_and_scissors
//
//  Created by Михаил Тихомиров on 17.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var choises = ["rock", "scissors", "paper"]
    @State private var app_answer = 0
    @State private var WinLooseState = 0
    @State private var OutputMessage = ""
    @State private var Score = 0
    @State private var FinalAlert = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .white, location: 0.15),Gradient.Stop(color: .secondary, location: 0.99)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {

                Text("Rock, Scissors, Paper")
                    .font(.title.bold().italic())
                Text("(Guess what? 🧐)")
                    .font(.custom("My weight", size: 20))
                    
                
                Spacer()
                
                
                VStack{
                    
                    Spacer()
                    Spacer()
                    Text("App`s answer:")
                        .font(.title2.bold())
                        
                    Image(choises[app_answer])
                        .renderingMode(.original)
                        .clipShape(Capsule())
                        .opacity(WinLooseState != 0 ? 1 : 0) // we can show up app`s choise
                        
                    Spacer()
                    
                    Text("Status: \(OutputMessage)")
                        .font(.title3).bold()
                        .foregroundColor(WinLooseState == 1 ? .green : WinLooseState == 2 ? .red : .black)
                        .opacity(WinLooseState != 0 ? 1 : 0)
                    
                    
                    Spacer()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .gray, location: 0.01),Gradient.Stop(color: .purple, location: 0.99)]), startPoint: .top, endPoint: .bottom).blur(radius: 5))
                .ignoresSafeArea()
                .padding(.vertical,0)
                .cornerRadius(.infinity)
                
                
                
                
                Spacer()
                
                
                
                VStack(spacing: 5){
                    Text("Tap the action:")
                        .font(.subheadline.weight(.semibold))
                    
                    ForEach(0..<3){ number in
                        Button {
                            // code
                            makeAmove(number)
                        } label: {
                            Image(choises[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                
                                
                        }
                    }
                    
                }
                
                
                
                    Text ("Score: \(Score)")
                        .foregroundColor(.black)
                        .font(.largeTitle.italic())
                
                    
                
                
                
                
            }
            .padding()
        
        }
        .alert(OutputMessage, isPresented: $FinalAlert){
            if Score == 8 {
                Button ("New Game") {
                    Score = 0
                    WinLooseState = 0
                }
            }
        }
    }
    
    func makeAmove(_ number:Int) {
        app_answer = Int.random(in: 0...2)
        
        if number == app_answer {
            OutputMessage = "That`s the same 🤝"
            WinLooseState = 3
        }
        
        if number == 0 && app_answer == 1 {
            OutputMessage = "You won!"
            WinLooseState = 1
        }else if number == 0 && app_answer == 2 {
            OutputMessage = "You lost!"
            WinLooseState = 2
        }else if number == 1 && app_answer == 2 {
            OutputMessage = "You won!"
            WinLooseState = 1
        }else if number == 1 && app_answer == 0 {
            OutputMessage = "You lost!"
            WinLooseState = 2
        }else if number == 2 && app_answer == 0 {
            OutputMessage = "You won!"
            WinLooseState = 1
        }else if number == 2 && app_answer == 1 {
            OutputMessage = "You lost!"
            WinLooseState = 2
        }
        
        
        
        if WinLooseState == 1 {
            Score += 1
        }else if WinLooseState == 2 && Score > 0 {
            Score -= 1
        }
        
        if Score == 8 {
            OutputMessage = "You Won this battle 👏"
            FinalAlert = true
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
