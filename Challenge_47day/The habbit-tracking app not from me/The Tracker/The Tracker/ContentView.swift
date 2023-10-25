//
//  ContentView.swift
//  The Tracker
//
//  Created by Михаил Тихомиров on 25.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink {
                        DetailView(activities: self.activities, activity: item)
                    } label: {
                        HStack {
                            VStack(alignment:.leading){
                                Text(item.name)
                                    .font(.headline)
                                Text (item.description)
                            }
                            Spacer()
                            Text ("\(item.completedTimes)")
                            
                        }
                    }

                }
            }
            .navigationTitle("Habit-tracking")
            .toolbar {
                Button{
                    self.showingAddActivity = true
                }label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivity(activities: self.activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
