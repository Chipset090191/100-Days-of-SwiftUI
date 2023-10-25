//
//  DataController.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 09.07.2023.
//
import CoreData
import Foundation


class DataControlle:ObservableObject {
    
    let container = NSPersistentContainer(name: "MyDataModel")
    
    init () {
        container.loadPersistentStores{ description, error in
            if let error = error {
                print ("Core Data failed to load: \(error.localizedDescription)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // ! For relationship not forget about that
        }
    }
    
}
