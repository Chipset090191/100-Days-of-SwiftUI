//
//  DetailView.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 08.07.2023.
//

import SwiftUI

struct DetailView: View {
    
    let user:User
    var users:[User]
    
    
    
    var body: some View {
        Form {
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
            
            Section {
                Text (user.about)
            }header: {
                Text ("About:")
                    .foregroundColor(.blue)
            }
            
            
            Section {
                NavigationLink{
                    Friends(user: user, users: users)
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
        DetailView(user: User(id: "sa", name: "Tima", age: 45, address: "kubanskaya", about: "My name", company: "Tander", isActive: false, friends: [Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Michael")]), users: [User]())
    }
}
