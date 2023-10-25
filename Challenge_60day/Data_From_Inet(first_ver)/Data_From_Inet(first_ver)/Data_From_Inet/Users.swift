//
//  Users.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 08.07.2023.
//

import Foundation

class Users:ObservableObject {
    
//    @Published var ArrayofUsers = [User]()
    
//    init(){}
    
    // we use async here so as swift understands that func might be completed at any moment while program is working (in parallel of prog cycle)
//    func loadData() async {
//        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
//            print ("Invalid URL")
//            return
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url) // (, _) - the second parameter here is info about data we get.. (size,..)
//            
//            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
//                ArrayofUsers = decodedResponse
//                
//            }
//                
//            
//        } catch {
//            print ("Invalid data")
//        }
//        
//    }
    
    
//    // to find user
//    func findUser (id:String) ->User {
//        guard let FindedUser = ArrayofUsers.first(where: { One in
//            One.id == id
//        }) else {
//            return ArrayofUsers.first!
//        }
//        return FindedUser
//
//    }
    
    
}


