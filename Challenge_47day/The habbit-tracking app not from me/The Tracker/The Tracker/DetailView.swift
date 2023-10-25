//
//  DetailView.swift
//  The Tracker
//
//  Created by Михаил Тихомиров on 25.05.2023.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var activities:Activities
    
    @State private var completedTimes = 0
    var activity:Activity
    
    
    var body: some View {
        Form {
            Section {
                Text ("\(self.activity.description)")
            }header: {
                Text ("Description for activity")
            }
            
            Section {
                Stepper(value: $completedTimes, in: 0...Int.max, step: 1){
                    Text ("Completed times: \(self.completedTimes)")
                }
            }header: {
                Text ("Change Completed Times")
            }
        }
        .navigationTitle(self.activity.name)
        .toolbar {
            Button{
                self.saveActivity()
            }label: {
                Text("Save")
            }
        }
        .onAppear{
            completedTimes = activity.completedTimes
        }
            
    }
    
    func saveActivity() {
        if let indexItem = self.activities.items.firstIndex(where: { item in
            item == self.activity
        }){
            let tempActivity = Activity(name: self.activity.name, description: self.activity.description, completedTimes: self.completedTimes)
            self.activities.items.remove(at: indexItem)
            self.activities.items.insert(tempActivity, at: indexItem)
            
            self.activities.saveActivities()
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(activities: Activities(), activity: Activity(name: "Name", description: "Description", completedTimes: 0))
    }
}
