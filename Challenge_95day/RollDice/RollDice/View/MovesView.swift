//
//  MovesView.swift
//  RollDice
//
//  Created by Михаил Тихомиров on 09.10.2023.
//
import CoreData
import SwiftUI

struct MovesView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var moves_Arch: FetchedResults<Moves>
    

    
    var body: some View {
        NavigationView{
            List{
                ForEach(moves_Arch) { move in
                    HStack{
                        Text("\(move.number)")
                        Spacer()
                        Text("\(move.date!.formatted(date: .omitted, time: .standard))")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("All Moves")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button{
                    deleteData()
                    dismiss()
                }label: {
                    Image(systemName: "trash")
                }
            }
        }
        
    }
    func deleteData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Moves")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try moc.execute(batchDeleteRequest)
            try moc.save()
                } catch {
                    // Handle the error appropriately, such as displaying an alert.
                    print("Error deleting data: \(error.localizedDescription)")
                }

    }
}

struct MovesView_Previews: PreviewProvider {
    static var previews: some View {
        MovesView()
    }
}
