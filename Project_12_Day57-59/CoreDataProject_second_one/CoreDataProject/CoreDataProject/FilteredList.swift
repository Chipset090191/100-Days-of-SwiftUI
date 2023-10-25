//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Михаил Тихомиров on 21.06.2023.
//

import SwiftUI

struct FilteredList: View {
    
    @FetchRequest var fetchRequest:FetchedResults<Singer>
    
    var body: some View {
        List (fetchRequest, id: \.self) { singer in
            Text ("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(filter:String) {
        // with underscore we are changing the whole fetchRequest
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
}


