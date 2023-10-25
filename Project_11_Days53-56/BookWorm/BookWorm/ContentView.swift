//
//  ContentView.swift
//  BookWorm
//
//  Created by Михаил Тихомиров on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
//        SortDescriptor(\.title, order: .reverse)  // we sorted on tilte with back order
        
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books:FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    }label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text (book.title ?? "Unknown Title")
                                    .font(.headline)
                                
                                Text (book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                                
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            showingAddScreen.toggle()
                        }label: {
                            Label("Add Book", systemImage: "plus")
                                .font(.largeTitle)
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets {
            let book = books[offset]
            moc.delete(book) // we are deleting from memory storage!
        }
        
        try? moc.save()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
