//
//  Friends.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 08.07.2023.
//

import SwiftUI

struct Friends: View {
    let user:User
    let users:Users
    
    var body: some View {
        List (user.friends) { friend in
            NavigationLink{
                DetailView(user: users.findUser(id: friend.id))
            }label: {
                Text (friend.name)
            }
        }
        .navigationBarTitle("List of \(user.name)`s friends", displayMode: .inline)
        .listStyle(.inset)
    }
}

struct Friends_Previews: PreviewProvider {
    static var previews: some View {
        Friends(user: User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", name: "Alford Rodriguez", age: 21, company: "Imkan", isActive: false, registered: Date.now, address: "f", about: "about info", friends: [Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel")]), users: Users())
    }
}
