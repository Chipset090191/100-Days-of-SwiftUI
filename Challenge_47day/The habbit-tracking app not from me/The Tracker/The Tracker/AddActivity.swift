//
//  AddActivity.swift
//  The Tracker
//
//  Created by Михаил Тихомиров on 25.05.2023.
//

import SwiftUI

struct AddActivity: View {
    
    @Environment (\.dismiss) var dismiss
    @ObservedObject var activities:Activities
    
    @State private var name = ""
    @State private var description = ""
    @State private var amount = 0
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                } header: {
                    Text ("Enter name of habit")
                }
                
                Section{
                    TextField("Descriptions", text: $description)
                }header: {
                    Text ("Enter description of habit")
                }
                
                Section{
                    Stepper(value: $amount, in: 0...Int.max, step: 1) {
                        Text("\(amount) times")
                    }
                }header: {
                    Text ("Completed times")
                }
                
            }
            .navigationTitle("Add new Activity")
            .toolbar {
                Button {
                    let item = Activity(name: self.name, description: self.description, completedTimes: self.amount)
                    self.activities.items.append(item)
                    
                    self.activities.saveActivities()
                    
                    dismiss()
                } label: {
                    Text("Save")
                }

            }
        }
    
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(activities: Activities())
    }
}
