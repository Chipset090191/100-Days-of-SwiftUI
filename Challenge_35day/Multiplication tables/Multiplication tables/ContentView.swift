//
//  ContentView.swift
//  Multiplication tables
//
//  Created by Михаил Тихомиров on 04.04.2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var answer:Int = 0                        // answer wheel style
    @State private var StateOfAnswer = 0                     // 0 - neutral, 1 - right, 2 - wrong
    @State private var tableForPractice = 2
    @State private var countOfQuestions = 5
    @State private var animationAmount = 1.0
    @State private var animationAmountIndicators = 0.0
    @State private var animationAmountAnswer = 0.8
    @State private var animatonAmountRhino = 0.0
    @State private var animationAmountCard = 0.0
    @State private var animationAmountWrongAnswers = 0.0
    @State private var State = 0                            // 0 - settings, 1 - practicing
    @State private var setOfPointers = [Int]()
    @State private var wrongAnswers = [String]()
    @State private var NextElement = 0
    @State private var showingFinalResult = false
    // MARK: -
    
    
    let minus:Character = "x"                              // that`s for wrong answers
    
    let x2 = ["2*1", "2*2", "2*3", "2*4", "2*5", "2*6", "2*7", "2*8", "2*9", "2*10"]
    let x3 = ["3*1", "3*2", "3*3", "3*4", "3*5", "3*6", "3*7", "3*8", "3*9", "3*10"]
    let x4 = ["4*1", "4*2", "4*3", "4*4", "4*5", "4*6", "4*7", "4*8", "4*9", "4*10"]
    let x5 = ["5*1", "5*2", "5*3", "5*4", "5*5", "5*6", "5*7", "5*8", "5*9", "5*10"]
    let x6 = ["6*1", "6*2", "6*3", "6*4", "6*5", "6*6", "6*7", "6*8", "6*9", "6*10"]
    let x7 = ["7*1", "7*2", "7*3", "7*4", "7*5", "7*6", "7*7", "7*8", "7*9", "7*10"]
    let x8 = ["8*1", "8*2", "8*3", "8*4", "8*5", "8*6", "8*7", "8*8", "8*9", "8*10"]
    let x9 = ["9*1", "9*2", "9*3", "9*4", "9*5", "9*6", "9*7", "9*8", "9*9", "9*10"]
    
    
    var RealAnswer:Int {
        answer + 1
    }
    
    var RealSetOfpointers:Int {
        setOfPointers[NextElement]
    }
    
    var RealItemInTable:String {
        switch tableForPractice {
        case 2:
            return x2[RealSetOfpointers]
        case 3:
            return x3[RealSetOfpointers]
        case 4:
            return x4[RealSetOfpointers]
        case 5:
            return x5[RealSetOfpointers]
        case 6:
            return x6[RealSetOfpointers]
        case 7:
            return x7[RealSetOfpointers]
        case 8:
            return x8[RealSetOfpointers]
        case 9:
            return x9[RealSetOfpointers]
        default:
            break
        }
       return ""
    }
    
//    Text (x2[RealSetOfpointers])
    
    var body: some View {
        NavigationView{
            ZStack {
                AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                    .ignoresSafeArea()
                    .blur(radius: 50)
                
                // MARK: Top line of greetings
                VStack {
                    HStack{
                        Spacer()
                        Spacer()
                        Spacer()
                        Text ("Just Do Multiplication")
                            .font(.title)
                            .bold()
                            .foregroundColor(.green)
                        Spacer()
                        Spacer()
                        
                        Button {
                            State = 0
                            StateOfAnswer = 0
                            animationAmountIndicators = 0.0
                            answer = 0
                            animationAmountAnswer = 0.8
                            animationAmountCard = 0.0
                            animationAmountWrongAnswers = 0.0
                            animatonAmountRhino = 0.0
                            setOfPointers.removeAll()            // clear the last element of collection
                            wrongAnswers.removeAll()             // the same
                            countOfQuestions = 5
                            
                        }label: {
                            Text ("🎲")
                        }
                        .scaleEffect(2)
                        .opacity(State == 1 ? 1 : 0)
                        Spacer()
                    }
                        
                // MARK: Indicators of answer
                        VStack{
                            HStack(spacing:100) {
                                
                                Image ("parrot")
                                    .renderingMode(.original)
                                    .opacity(State == 0 || (State == 1 && StateOfAnswer == 2) ? 1:0)
                                    .scaleEffect(State == 0 ? 1 : animationAmountIndicators)
                                    .animation (.interpolatingSpring(stiffness: 40, damping: 5), value:animationAmountIndicators)
                                Image ("snake")
                                    .renderingMode(.original)
                                    .opacity(State == 0 || (State == 1 && StateOfAnswer == 1) ? 1:0)
                                    .scaleEffect(State == 0 ? 1 : animationAmountIndicators)
                                    .animation (.interpolatingSpring(stiffness: 40, damping: 5), value:animationAmountIndicators)
                                
                            }
                        }

            
                    Spacer()
                    Spacer()
                    
                    // MARK: Settings
                    if State == 0 {
                        VStack(spacing: 10){
                            Section{
                                HStack{
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    Stepper("Choose the table:  x\(tableForPractice)", value: $tableForPractice, in: 2...9)
                                        .font(.title2)
                                        .foregroundColor(.yellow)
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    Stepper("Count of questions:  \(countOfQuestions)", value: $countOfQuestions, in: 5...20,step: 5)
                                        .font(.title2)
                                        .foregroundColor(.yellow)
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                }
                                
                                HStack{
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    
                                    Text ("Tap to START practice 👉")
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    Button {
                                        MakeSet()
                                        State = 1    // state for start
//                                        animationAmount = 4
                                        print (RealSetOfpointers)
                                        
                                    }label: {
                                        Image ("rhino")
                                            .renderingMode(.original)
                                            .opacity(1)
                                        
                                    }
                                    .scaleEffect(0.7)
                                    .overlay(
                                        Circle()
                                            .stroke(lineWidth: 4).fill(.green)
                                            .scaleEffect(animatonAmountRhino)
                                            .animation (
                                                .easeInOut(duration: 2)
                                                .repeatForever(autoreverses: false),
                                                value: animatonAmountRhino
                                            )
                                    )
                                    .onAppear{
                                        animatonAmountRhino = 1
                                    }
                                }
                                
                                
                                
                            }header: {
                                Text ("Make your sets first:")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .bold().italic()
                            }
                        }
                        .frame(width: 380, height: 250)
                        .background(.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 80))
                        .shadow(radius: 2)
                        
//                        .scaleEffect(animationAmount)
//                        .blur(radius: (animationAmount - 1) * 3)
//                        .opacity(State == 0 ? 1 : 0)
//                        .animation(.default, value: animationAmount)

                    }
                    
                    Spacer()
                    
                    // MARK: Wrong answers
                    if State == 1 {
                        // Our checker list
                        VStack{
                            Form{
                                Section {
                                    ForEach (wrongAnswers,id: \.self) { item in
                                        HStack {
                                            Image(systemName: "\(minus).circle")
                                                .foregroundColor(.red)
                                            Text (item)
                                                .italic()
                                                
                                                
                                        }
                                    }
                                }header: {
                                    Text ("Wrong answers:")
                                        
                                }
                            }
                            
                        }
                        .frame(width: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
//                        .border(Color.purple,width: 2)
                        .opacity(State == 1 && !wrongAnswers.isEmpty ? animationAmountWrongAnswers:0)
                        .animation(.default, value: animationAmountWrongAnswers)
                        
                        // End the list
                        
                        // MARK: card for answer
                        VStack(spacing: 10) {
                            
//                            Text (x2[setOfPointers[NextElement]])
                            Text (RealItemInTable)
                            
                            
                                .font(.system(size: 50))
                                .font(.largeTitle).bold()
                                .foregroundColor(.yellow)
                            
                            
                            Picker("Enter the value",selection: $answer){
                                ForEach(1..<100) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 130, height: 50,alignment: .center)
                            .background(.indigo)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            
                            Text ("Hippo🦛 to accept the answer")
                            
                        }
                        .frame(width: 300, height: 150)
                        .background(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .cyan, location: 0.01),Gradient.Stop(color: .purple, location: 0.99)]), startPoint: .top, endPoint: .bottom).blur(radius: 0))
                        .ignoresSafeArea()
                        .padding(.vertical,0)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                        .rotation3DEffect(.degrees(animationAmountCard), axis: (x: 1, y: 0, z: 0))
                        .onTapGesture {
                            if StateOfAnswer != 0 && countOfQuestions > 0{
                                answer = 0
                                setOfPointers.removeFirst()    // here we remove previous element
                                animationAmountIndicators = 0
                                animationAmountAnswer = 0.8
                                animationAmountCard = 0.0
                                StateOfAnswer = 0
                                withAnimation(.interpolatingSpring(stiffness: 100, damping: 5)){
                                    animationAmountCard = 360
                                }
                            }
                        }
                    }
                    
                    // MARK: hippo button for answer
                    VStack{
                            Button{
                                guard StateOfAnswer == 0 else {return}
                                    animationAmountAnswer = 0.5
                                    animationAmountIndicators = 1
                                    gameCheck()
   
                            }label: {
                                Image ("hippo")
                                    .renderingMode(.original)
                                    
                                    
                            }
                            .scaleEffect(StateOfAnswer != 0 ? animationAmountAnswer : 0.8)
                            .opacity(State == 0 ? 0 : StateOfAnswer == 0 ? 1 : animationAmountAnswer)
                            .animation (.default, value:animationAmountAnswer)

                        }
                }
                
            }
            // MARK: alert
            .alert("You finished this set!", isPresented: $showingFinalResult) {
                Button("Cancel", role: .cancel) { } // empty code for button
            } message: {
                Text("Tap 🎲 to set again")
            }

            
        }
        
    }
    
    // MARK: methods
    func MakeSet() {
        for _ in 0...countOfQuestions - 1 {
            let temp = Int.random(in: 0...9)
            setOfPointers.append(temp)
        }
        
        
    }
    
    func gameCheck(){
        
        countOfQuestions -= 1
        
        // final item check
        if countOfQuestions == 0 {
           showingFinalResult = true
        }
        
        var number1 = 0
        var number2 = 0
        
        let equation = RealItemInTable
        for index in equation {
            if index != "*"{
                if number1 == 0 {
                    number1 = Int(String(index))!
                }else if equation.hasSuffix("10") {
                    number2 = 10
                }else {
                    number2 = Int(String(index))!
                }
            }
        }
        
        // then we`re gonna check

        if number1 * number2 == RealAnswer {
            StateOfAnswer = 1
        }else {
            StateOfAnswer = 2
            animationAmountWrongAnswers = 1.0
            wrongAnswers.append(equation + " is not - \(String(RealAnswer)), it is - \(String(number1 * number2))")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
