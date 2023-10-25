//
//  Friends.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 08.07.2023.
//

import SwiftUI

struct Friends: View {
    
    
    let user:User
    var users:[User]
    
    var body: some View {
        List (user.friends) { friend in
            NavigationLink{
                DetailView(user: findUser(id: friend.id), users: users)
            }label: {
                Text (friend.name)
            }
        }
        .navigationBarTitle("List of \(user.name)`s friends", displayMode: .inline)
        .listStyle(.inset)
    }
    
    
    // to find user
    func findUser (id:String) ->User {
        guard let FindedUser = users.first(where: { One in
            One.id == id
        }) else {
            return users.first ?? User(id: "sa", name: "Tima", age: 45, address: "kubanskaya", about: "My name", company: "Tander", isActive: false, friends: [Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Michael")])
        }
        return FindedUser

    }
    
    
    

}

struct Friends_Previews: PreviewProvider {
    static var previews: some View {
        Friends(user: User(id: "sa", name: "Tima", age: 45, address: "kubanskaya", about: "My name", company: "Tander", isActive: false, friends: [Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Michael")]), users: [User]())
    }
}
