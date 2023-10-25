//
//  AddNewHabbit.swift
//  Tracking_app
//
//  Created by Михаил Тихомиров on 25.05.2023.
//

import SwiftUI

struct AddNewHabbit: View {
    
    
    @ObservedObject var habbits:Habbit
    @State private var name = ""
    @State private var description = ""
    @State private var amount = 0
    
    
    @Environment (\.dismiss) var dismiss   // for the .sheet
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Name of the habbit", text: $name)
                
                    TextEditor(text: $description)
                        
                }
                
                
            }
            .navigationTitle("Add a new habbit")
            .toolbar{
                Button ("Save") {
                    let item = HabbitItem(name: name, description: description, amount: amount)
                    habbits.item.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddNewHabbit_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabbit(habbits: Habbit())
    }
}
