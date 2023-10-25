//
//  ContentView.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 04.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationView{
            List(users) { user in
                NavigationLink{
                    DetailView(user: user, users: users)
                }label: {
                    VStack {
                        Text(user.name)
                            .font(.title3)
                        HStack(alignment: .lastTextBaseline) {
                            Text("is Active:")
                                .font(.caption)
                        
                            
                            Text(String(user.isActive))
                                .foregroundColor(user.isActive == true ? .green:.gray)
                        }
                        
                    }
                }
            }
            .listStyle(.plain)
            .task {
                // await - that func may wait data from net!
                await loadData()
            }
            .navigationTitle("Data from INET")
        }
        

    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print ("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url) // (, _) - the second parameter here is info about data we get.. (size,..)
            
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                users = decodedResponse
                
            }
                
            
        } catch {
            print ("Invalid data")
        }
        
    }
    
//    // to find user
//    func findUser (id:String) ->User {
//        guard let FindedUser = users.first(where: { One in
//            One.id == id
//        }) else {
//            return users.first!
//        }
//        return FindedUser
//
//    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
