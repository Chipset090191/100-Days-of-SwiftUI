//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Михаил Тихомиров on 21.06.2023.
//
import CoreData
import SwiftUI

// in this generic variation we say that you`re gonna give me managed object and Content of View to list data
struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest:FetchedResults<T> // here we say the data may be whatever we want
    let content: (T) -> Content   // we say I will give you as a param (T - whatever) to your content closure and your job is to give me back some content to show inside my list and that must be swift UI VIew!
    
    
    var body: some View {
        List (fetchRequest, id: \.self) { item in
            self.content(item)   // we pass the param to our content closure
        }
    }
    
    // with @escaping we say that if`s gota be used later on not now
    // @ViewBuilder provides us with a view: List, etc...
    init(filterKey:String, filterValue: String, For_predicate:String, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        // with underscore we are changing the whole fetchRequest
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(For_predicate) %@", filterKey, filterValue))
        self.content = content
    }
}


