//
//  Data_From_InetApp.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 06.07.2023.
//

import SwiftUI

@main
struct Data_From_InetApp: App {
    
    @StateObject private var dataController = DataControlle()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
