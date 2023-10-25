//
//  DataController.swift
//  BookWorm
//
//  Created by Михаил Тихомиров on 11.06.2023.
//

import CoreData
import Foundation



class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")  // we prepared a link for our dataModel (Bookworm - data model file)
    
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print ("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
    }
}
