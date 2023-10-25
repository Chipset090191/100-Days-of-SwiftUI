//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Михаил Тихомиров on 12.06.2023.
//

import SwiftUI

@main
struct BookWormApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
