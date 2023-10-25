//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Михаил Тихомиров on 21.06.2023.
//



import SwiftUI

// MARK: Chellenge 2. Used Enum instead of array. we implemented
enum filter_:String {
    case BEGINSWITH, CONTAINS
}

struct ContentView: View {
    @Environment (\.managedObjectContext) var moc
    @State private var lastNameFilter = "r"
    @State private var Predicate_Str = "CONTAINS"
    
    // MARK: Chellenge 1. Used Picker to choose whatever predicates we wanna use from our array let predicates
    let predicates = ["CONTAINS", "BEGINSWITH", "CONTAINS[c]", "BEGINSWITH[c]"]
    
    // MARK: Chellenge 3. Used sort descriptors to expand our filter
    let sortDescriptors = [NSSortDescriptor(keyPath: \Singer.lastName, ascending: false)]
    
    var body: some View {
        VStack {
            //list of mathcing singers
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, For_predicate: filter_.CONTAINS.rawValue, sortDescriptors: sortDescriptors) { (singer: Singer) in
                // now we are gonna provide that closure with content to get back what we want
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button ("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button ("Show A") {
                lastNameFilter = "A"
            }
            
            Button ("Show S") {
                lastNameFilter = "S"
            }
            
            Picker("Choose Predicate", selection: $Predicate_Str) {
                ForEach(predicates, id: \.self) {
                    Text("\($0)")
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
