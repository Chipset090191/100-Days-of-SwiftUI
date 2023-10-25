//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Михаил Тихомиров on 21.06.2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
