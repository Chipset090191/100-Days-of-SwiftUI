//
//  Prospect.swift
//  HotProspects
//
//  Created by Михаил Тихомиров on 28.08.2023.
//

import SwiftUI

class Prospect:Identifiable, Codable {
      var id = UUID()
      var name = "Anonymous"
      var emailAdress = ""
      fileprivate(set) var isContacted = false  // fileprivate(set) - that`s specifically hard to explain but we need that to avoid problems with our app in the future when we want change property from somewhere in our code
    // fileprivate(set) - doesn`t allow us to change property from somewhere else except the context of a file where this property is. Then
    // below you can seen the method where we change state of the property
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]                  // private(set) - means that you can read the array of people anywhere bu
    let saveKey = "SavedData"                                       // you cannot write data form somewhere except our Prospects class!ß
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
                
        }
        
        // no saved data!
        people = []
    }
    
    private func save() {                                       // we use private because no one else should call save() except of our our                                                            // methods inside of Class
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()         // we tell to our @state_object and @Environment that our "prospects" will be changed
        prospect.isContacted.toggle()   // and then change our property in array
        save()
    }
    
    
    
}
