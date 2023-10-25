//
//  ContentView.swift
//  HotProspects
//
//  Created by Михаил Тихомиров on 23.08.2023.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var prospects = Prospects()
    
    
    
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label ("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects) // we injected our object "prospects" into TabView so
        // it will be available for all the views inside the tab
        // when we click through these buttons every time we change our environment object and then
        //@EnvironmentObject var prospects:Prospects  watches it and reinvoke View
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
