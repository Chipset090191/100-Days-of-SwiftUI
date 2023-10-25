//
//  EditCards.swift
//  Flashzilla
//
//  Created by Михаил Тихомиров on 19.09.2023.
//

import SwiftUI

struct EditCards: View {
    
    @Environment (\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView{
            List {
                Section("Add new card") {
                    TextField ("Prompt", text: $newPrompt)
                    TextField ("Answer", text: $newAnswer)
                    Button ("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar{
                Button("Done") {
                
                    done()
                }
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
            
            
        }
    }
    
    func done() {

    
        dismiss()
    }
    
    func loadData() {
        
        let filename = FileManager.documentsDirectory.appendingPathComponent("Cards")
        
        do {
            let data = try Data(contentsOf: filename)
            let decoded = try JSONDecoder().decode([Card].self, from: data)
            cards = decoded
        } catch {
            print ("Couldn`t load data")
        }
        
        
        
//        if let data = UserDefaults.standard.data(forKey: "Cards") {
//            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//                cards = decoded
//            }
//        }
//        let data = try? JSONEncoder().encode(<#T##value: Encodable##Encodable#>)
        
        
    }
    
    func saveData() {
        
// DocumentsDirectory example
        let filename = FileManager.documentsDirectory.appendingPathComponent("Cards")
        
        do{
            let data = try JSONEncoder().encode(cards)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
        } catch {
            print ("couldn`t write data")
        }
        
// User Default example
//        if let data = try? JSONEncoder().encode(cards) {
//            UserDefaults.standard.set(data, forKey: "Cards")
//        }
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)  // we trim just from the ends
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        
        // MARK: Challenge 1
        
        newPrompt = ""
        newAnswer = ""
        
        saveData()
    }
    
    func removeCards(at offsets:IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
