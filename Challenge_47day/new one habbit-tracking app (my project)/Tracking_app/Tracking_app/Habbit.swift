//
//  Habbit.swift
//  Tracking_app
//
//  Created by Михаил Тихомиров on 25.05.2023.
//

import Foundation

class Habbit: ObservableObject {
    @Published var item = [HabbitItem]() { // we use here property observers like didSet to encode data that`s been changed.
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(item) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init (){  // custom init() - by initializing class the custom init() helps us to read data from user defaults by ussing its body
        if let savedItems =  UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([HabbitItem].self, from: savedItems) {
                item = decodedItems
                return // if it`s ok we save our array to array item and then return
            }
        }
        item = [] // empty array when we could not get the data from user defaults
    }
    
}
