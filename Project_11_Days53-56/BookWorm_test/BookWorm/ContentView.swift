//
//  ContentView.swift
//  BookWorm
//
//  Created by Михаил Тихомиров on 09.06.2023.
//

import SwiftUI




struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    
    // here we are extracting the all "student" data with no sort filter
    @FetchRequest(sortDescriptors: []) var students:FetchedResults<Student>
    
    
    var body: some View {
        VStack {
            List (students) { student in
                Text (student.name ?? "Unknown")
            }
            
            Button ("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!
                
                
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                
                try? moc.save()
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
