//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Михаил Тихомиров on 09.06.2023.
//

import SwiftUI

@main
struct BookWormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // we inject our data contoller to environment right over here
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
