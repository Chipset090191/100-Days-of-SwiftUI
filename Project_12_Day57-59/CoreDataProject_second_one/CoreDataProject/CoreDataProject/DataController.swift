//
//  DataController.swift
//  CoreDataProject
//
//  Created by Михаил Тихомиров on 20.06.2023.
//
import CoreData
import Foundation


class DataController:ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
        
        init() {
            container.loadPersistentStores{ description, error in
                if let error = error {
                    print ("Core data failed to load: \(error.localizedDescription)")
                    
                }
            }
        }
}
