//
//  DetailView.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 07.07.2023.
//

import SwiftUI

struct DetailView: View {
    
    let user:User
//    let users:Users
    
    var body: some View {
            Form{
                HStack{
                    Text("Id:")
                        .bold()
                    Text(String (user.id))
                }
                HStack{
                    Text("Age:")
                        .bold()
                    Text(String (user.age))
                }
                
                HStack{
                    Text("Company:")
                        .bold()
                    Text(user.company)
                }
                
                HStack{
                    Text("Address:")
                        .bold()
                    Text(user.address)
                }
                
                
                HStack{
                    Text("Registered:")
                        .bold()
                    Text("\(user.registered.formatted(date: .numeric, time: .shortened))")
                }
                
                Section {
                    Text (user.about)
                }header: {
                    Text ("About:")
                        .foregroundColor(.blue)
                }
                
                Section {
                    NavigationLink{
                        Friends(user: user, users: Users())
                    }label: {
                        Text ("List of friends")
                    }
                }header: {
                    Text ("Friends:")
                        .foregroundColor(.blue)
                }
                
                
            }
            .navigationTitle("Details on: \(user.name)")
            .font(.footnote)
            .navigationBarTitleDisplayMode(.inline)
        }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: User(id: "0c405a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Alfonso", age: 13, company: "Company", isActive: false, registered: Date.now, address: "d", about: "about info", friends: [Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Michael")]))
    }
}
