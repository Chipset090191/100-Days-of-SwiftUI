//
//  Activity.swift
//  The Tracker
//
//  Created by Михаил Тихомиров on 25.05.2023.
//

import Foundation
import SwiftUI

class Activities:ObservableObject {
    @Published var items = [Activity]()
    
    func saveActivities() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
    
}



struct Activity:Identifiable,Codable,Equatable {
    let id = UUID()
    let name: String
    let description:String
    var completedTimes:Int
}


