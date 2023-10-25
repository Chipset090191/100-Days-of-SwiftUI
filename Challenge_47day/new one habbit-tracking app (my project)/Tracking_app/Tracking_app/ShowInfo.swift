//
//  ShowInfo.swift
//  Tracking_app
//
//  Created by Михаил Тихомиров on 25.05.2023.
//

import SwiftUI

struct ShowInfo: View {
    //    var item:HabbitItem
    //    var habbits = Habbit()
        @ObservedObject var habbits:Habbit
        
        
    //    @State private var amount = 0
        
        let item:HabbitItem
        
        @State private var CompletionCount = 0
        @State private var EditedDescription = ""
        
    
        var body: some View {
                Form{
                    Section{
                        TextEditor(text: $EditedDescription)
                    }header: {
                        Text ("Description:")
                    }
                    
                    Section {
                        HStack{
                            Text ("\(self.CompletionCount)")
                            Spacer()
                            
                            Button ("Tap to complete") {
                                
                                CompletionCount += 1

                            }
                            .font(.footnote)
                            .foregroundColor(.black)
                            Image(systemName: "hand.tap")
                        }
                        
                    }header: {
                        
                        Text("Completed:")
                            .foregroundColor(.green)
                            .font(.headline)
                            .bold()
                    }
                }
                .navigationTitle(item.name)
                .toolbar {
                    Button{
                        let index = habbits.item.firstIndex(of: item)
                        habbits.item[index!].amount = CompletionCount
                        habbits.item[index!].description = EditedDescription
                    }label: {
                        Text("Save")
                    }
                }
                .onAppear{ // by using this modifier we can write down our @State properties 
                    self.CompletionCount = item.amount
                    self.EditedDescription = item.description
                }
            }
    
    
    
}

struct ShowInfo_Previews: PreviewProvider {
    static var previews: some View {
        ShowInfo(habbits: Habbit(), item: HabbitItem(name: "name", description: "Description", amount: 0))
    }
}
