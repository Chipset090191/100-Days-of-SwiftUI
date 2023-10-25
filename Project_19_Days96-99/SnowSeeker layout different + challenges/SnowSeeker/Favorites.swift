//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Михаил Тихомиров on 17.10.2023.
//

import Foundation

class Favorites: ObservableObject{
    private var resorts: Set<String>    // that`s our favorite resorts
    private let saveKey = "Favorites"
    
    init() {
        // MARK: must be finished 1
        // user defaults load or smth else
        // load our saved data here
        
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
               resorts = decoded
               return
            }
        }
        
        resorts = []
    }
    
    func contains(_ resort:Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()  // this will send notification to swift UI
        resorts.insert(resort.id)
        save()
    }
    
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    
    func save() {
        // write out our data
        // MARK: must be finished 2
        
        if let data = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
}
