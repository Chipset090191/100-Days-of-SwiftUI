//
//  ContentView.swift
//  Tracking_app
//
//  Created by Михаил Тихомиров on 25.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habbits = Habbit()
    
    @State private var showingSheet = false
    
    

    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(habbits.item, id: \.id) { item in
//                        HStack{
                        NavigationLink {
                            // code
                            ShowInfo(habbits: habbits, item: item)
                            
                        }label: {
                            HStack {
                                Image(systemName: "note")
                                    .foregroundColor(.green)
                                Text (item.name)
                                    .font(.headline)
                                
                                Spacer()
                                Text("Completed: \(item.amount)")
                                    .font(.caption)
                            }
                        }
                            
                            
//                        }
                    }
                    .onDelete(perform: removeItems)
                    
                    
                }
                .listStyle(.grouped)
                
                Button ("New habbit") {
                    showingSheet = true
                }
                
            }
            .navigationTitle("Your Tracker")
            .toolbar{
                EditButton()
            }
        }
        .sheet(isPresented: $showingSheet) {
            AddNewHabbit(habbits: habbits)
        }
        
        }
    
    // removing our Item
    func removeItems (at offsets: IndexSet) {
        habbits.item.remove(atOffsets: offsets)
    }
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
