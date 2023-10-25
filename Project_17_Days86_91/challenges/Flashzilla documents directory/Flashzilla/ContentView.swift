//
//  ContentView.swift
//  Flashzilla
//
//  Created by Михаил Тихомиров on 06.09.2023.
//

import SwiftUI

// that`s our modifier to place our cards of screen
extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    
    @Environment (\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment (\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var cards = [Card]()
    
    //++ our timer
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //++
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    @State private var needToMove = false
    
    
    
   
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text ("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                    //MARK: Challenge 3.3
                        CardView(card: cards[index]) {correct in
                            withAnimation {
                                removeCard(at: index, isSuccess: correct)
                            }
                        }
                        .stacked(at: index, in: cards.count)  // we offset every card in collection relatively
                        .allowsHitTesting(index == cards.count - 1)  // here we swipe just only front card of our deck
                        .accessibilityHidden(index < cards.count - 1)  // we ignore voice over pronounciation, except of the front one
                    }
                    
                }
                .allowsHitTesting(timeRemaining > 0) // this modifier allows us swiping until the condition is true!
                
                
                if cards.isEmpty {
                    Button("Start again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            // in this stack we are going to design a new card
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    }label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled { // that mode for colorblind users
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation{
                                // MARK: Challenge 3.5
                                removeCard(at: cards.count - 1, isSuccess: false)
                            }
                        }label: {
                            Image (systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, isSuccess: true)
                            }
                        }label: {
                            Image (systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer is being correct.")
                        
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
                
        } // onReceive and onChangeof (thats for timer) to ZStack
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init) // we add init here by using content because we do not pass any values! that`s simple approach. Remember this thing must be a function that takes no parameters
        .onAppear(perform: resetCards)
        
        
        
    }
    
    func removeCard(at index: Int, isSuccess: Bool) {
        
        guard index >= 0 else { return }  // if we don`t have cards we just return (for differentiat without colors mode)

        //MARK: Challenge 3.4
        let card = cards.remove(at: index)  // we get that Card we deleted here
        
        if !isSuccess {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cards.insert(card, at: 0)
            }
        }
        
        
        // here we stop timer
        if cards.isEmpty {
            isActive = false
        }
        
    }
    
    // to start game again
    func resetCards() {

        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    // load cards for content View from UserDefaults
    func loadData() {
        
        let filename = FileManager.documentsDirectory.appendingPathComponent("Cards")
        
        do {
            let data = try Data(contentsOf: filename)
            let decoded = try JSONDecoder().decode([Card].self, from: data)
            cards = decoded
            
        } catch {
            print ("Couldn`t load the data")
        }
        
        
        
// UserDefault example
//        if let data = UserDefaults.standard.data(forKey: "Cards") {
//            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//                cards = decoded
//            }
//        }
    }
    

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
