//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Михаил Тихомиров on 10.10.2023.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}


struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    
    @State private var searchText = ""
    
    let sortType = ["Runs", "Elevation"]
    @State private var selectedOrder = "Runs"
    
    
    var body: some View {
        NavigationView {
            List(finalSortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a fovorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(content: {
                        Picker("Choose sort type", selection: $selectedOrder) {
                            ForEach(sortType, id: \.self) { sorttype in
                                Text(sorttype == "Runs" ? "Runs ⛷️" : "Elevation 🏔️")
//                                Text("\($0) ⛷️🏔️")
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                })
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText)
            
            WelcomeView()   // that will work for iphone+ size when we in landscape mode
        }
        .environmentObject(favorites) // so we attached to the navigationView so all Views inside it will get that if it needs
        .phoneOnlyNavigationView() // with this modifier when we change the orientation on max versions the contents stay the same as on the typical one.
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var finalSortedResorts: [Resort] {
        if selectedOrder == "Runs" {
            return filteredResorts.sorted {$0.runs > $1.runs}
        } else
        {
            return filteredResorts.sorted {$0.elevation > $1.elevation}
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
