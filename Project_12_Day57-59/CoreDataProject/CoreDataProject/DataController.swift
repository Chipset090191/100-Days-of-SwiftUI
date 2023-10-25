//
//  DataController.swift
//  CoreDataProject
//
//  Created by Михаил Тихомиров on 17.06.2023.
//

import Foundation
import CoreData

class DataController:ObservableObject {
    let container = NSPersistentContainer(name: "CoreData")
        
        init() {
            container.loadPersistentStores{ description, error in
                if let error = error {
                    print ("Core data failed to load: \(error.localizedDescription)")
                }
            }
        }
}
