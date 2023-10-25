//
//  Users.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 06.07.2023.
//

import Foundation
import SwiftUI
import CoreData


class Users: ObservableObject {

    // we use static here in place and lower to not create instances of our class !! for example in context View!
    static func loadDataToCD(moc:NSManagedObjectContext) {
        
        loadDataFromJson { (users) in
            
            // DispatchQueue.main.async - helps us to start this closure async in main thread to preventing any UI responsiveness issues.
            DispatchQueue.main.async {
                
                var tempUsers = [CashedUser]()
                
                for user in users {
                    let newUser = CashedUser(context: moc)
                    newUser.name = user.name
                    newUser.id = user.id
                    newUser.company = user.company
                    newUser.isActive = user.isActive
                    newUser.age = Int16(user.age)
                    newUser.registered = user.registered
                    newUser.tags = user.tags.joined(separator: ";")
                    tempUsers.append(newUser)
                }
                for i in 0..<users.count {
                    for friend in users[i].friends {
                        let newFriend = CashedFriend(context: moc)
                        newFriend.id = friend.id
                        newFriend.name = friend.name
                        
                        tempUsers[i].addToFriends(newFriend)
                    }
                }
                
                do {
                     try moc.save()
                } catch let error{
                    print (" Could not save data \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    static func loadDataFromJson(completion:@escaping ([User]) -> ()) {
        
        let stringURL = "https://www.hackingwithswift.com/samples/friendface.json"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601  // to get data correctly
        
        guard let url = URL(string: stringURL) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print ("No data in response \(error?.localizedDescription ?? "No data")")
                return
            }
            
            if let decoderUser = try? decoder.decode([User].self, from: data) {
                completion(decoderUser)
            }
        }.resume()
        
        
    }
    

    
    
//    func findUser (id:String) ->User {
//        guard let FindedUser = arrayOfUsers.first(where: { One in
//            One.id == id
//        }) else {
//            return arrayOfUsers.first ?? User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", name: "Alford Rodriguez", age: 21, company: "Imkan", isActive: false, registered: Date.now, address: "f", about: "about info", friends: [Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel")])
//        }
//        return FindedUser
//    }
    
}
