//
//  RollDiceApp.swift
//  RollDice
//
//  Created by Михаил Тихомиров on 08.10.2023.
//

import SwiftUI

@main
struct RollDiceApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
