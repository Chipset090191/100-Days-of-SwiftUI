//
//  ContentView.swift
//  Project_5
//
//  Created by Михаил Тихомиров on 23.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none) // turn off capitalization
                }
                
                Section {
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement() // we ignore voiceover from all element here
//                        .accessibilityLabel("\(word), \(word.count) letters") // and then instead it pronouns loudly the text in label that we form
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                        
                        
                        
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)  // we type the Enter to accept the word!
            .onAppear(perform: startGame)
            .alert(errorTitle,isPresented: $showingError){
                Button("OK",role: .cancel){ } // with no action code!
            }message: {
                Text(errorMessage)
            }
            
        }
        

    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count >= 3 && answer != rootWord else {return}
        
        // Extra validation to come
        
        // first we chack maybe the word was used. if it`s not go next func isPossible
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return // if the word was used then we interrupt adding newWord!
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can`t spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognised", message: "You can`t just make them up, you know!")
            return
        }
        
        withAnimation{                              // we screwed animation
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame () {
        // first we use a bundle to point where the file is located!
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            // we transfer this file to our app by using String method
            if let startWords = try? String(contentsOf: startWordsURL){
                // next we creat an array from this words, where every word that is one of the elements of array
                let allWords = startWords.components(separatedBy: "\n")
                
                // and in rootWord we get one of the words from file randomly
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    
    
    func isOriginal(word:String)-> Bool {
        !usedWords.contains(word)
    }
    
    
    
    func isPossible(word:String)->Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
        
    }
    
    
    // here we can check for the real word!
    
    func isReal(word:String)-> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title:String, message:String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
