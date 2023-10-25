//
//  ContentView.swift
//
//  Created by Михаил Тихомиров on 08.10.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @State private var thrown = false
    @State private var diceResult = 0
    @State private var showingMoves = false
    
    
    
    @State private var moves = [Int]()
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Current move:")
                        .font(.title3)
                        .italic()
                        .foregroundColor(.green)
                        .padding(.leading)
                    Text ("\(diceResult)")
                        .bold()
                        .font(.title2)
                        .opacity(diceResult == 0 ? 0 : 1)
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
               
                
                let dragGesture = DragGesture()
                    .onChanged{ value in
                        withAnimation{
                            offset = value.translation
                            if abs(offset.width) > 80 || abs(offset.height) > 80 {
                                thrown = true
                            } else {
                                thrown = false
                            }
                        }
                    }
                    .onEnded{ _ in
                        withAnimation{
                            if thrown {
                                diceResult = Int.random(in: 1...6)
                                
                                saveToPhone()
                            }
                            offset = .zero
                            isDragging = false
                            thrown = false
                        }
                        
                    }
                let pressGesture = LongPressGesture()
                    .onEnded { value in
                        withAnimation{
                            isDragging = true
                        }
                    }
                
                let combined = pressGesture.sequenced(before: dragGesture)
                
                
                DiceView()
                    .scaleEffect(isDragging ? 1.5 : 1)
                    .rotationEffect(.degrees(abs(offset.width) + Double(Int.random(in: 1...100))))
                    .offset(offset)
                    .gesture(combined)
                    .overlay(
                        Circle()
                            .foregroundColor(thrown ? .green: .gray)
                            .opacity(thrown ? 0.9 : 0.25)
                            .blur(radius: thrown ? 0.3 : 0)
                    )
                Spacer()
            }
            .navigationTitle("Roll Dice")
            .sheet(isPresented: $showingMoves, content: {
                MovesView()
            })
            .toolbar {
                Button{
                    showingMoves = true
                }label: {
                    Text("🎲")
                        .scaleEffect(2)
                }
            }
            }
        
            
        }
    
    func saveToPhone() {
        let storeMoves = Moves(context: moc)
        storeMoves.date = Date()
        storeMoves.number = Int16(diceResult)
        
        try? moc.save()
        
    }
    
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
