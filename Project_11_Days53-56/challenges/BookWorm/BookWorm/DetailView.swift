//
//  DetailView.swift
//  BookWorm
//
//  Created by Михаил Тихомиров on 13.06.2023.
//

import SwiftUI

struct DetailView: View {
    let book:Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    // MARK: Challenge 3
    // adding time for review
    var dateFormatter: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .short
        formater.timeStyle = .short
        return formater
    }
    
    
    
    var body: some View {
        ScrollView {
            ZStack (alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text (book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
                Text(book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
            
            
            Text (book.review ?? "Unknown review")
                .padding()
            
            
                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)
            
            // MARK: Challenge 3
            HStack {
                Text ("Review made on:")
                    .font(.headline)
                    .italic()
                Text ("\(book.date ?? Date(), formatter: dateFormatter)")
                    
            }
            .padding(.top, 10)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button ("Delete", role: .destructive, action: deleteBook)
            Button ("Cancel", role: .cancel) {}
        }message: {
            Text ("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            }label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
//        try? moc.save()
        
        dismiss()
    }
    
}


