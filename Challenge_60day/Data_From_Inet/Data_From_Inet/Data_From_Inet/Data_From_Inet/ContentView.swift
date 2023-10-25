//
//  ContentView.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 06.07.2023. with a help of PetroOnishchuk https://github.com/PetroOnishchuk/100-Days-Of-SwiftUI.git. I got this code from there and added a litle mine.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var users = Users()
    var body: some View {
        NavigationView{
            List(users.arrayOfUsers) { user in
                NavigationLink{
                    DetailView(user: user)
                }label: {
                    VStack(alignment: .leading){
                        Text (user.name)
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
            .navigationTitle("Data from net")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
