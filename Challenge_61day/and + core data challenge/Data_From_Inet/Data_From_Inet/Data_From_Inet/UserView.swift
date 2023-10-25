//
//  UserView.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 13.07.2023 
//

import SwiftUI

struct UserView: View {
    
    @State private var isShowFriendList = false
    
    var user:CashedUser
    
    var body: some View {
        NavigationView{
            
                Form {
                    Section {
                        VStack{
                            Text (user.wrappedName)
                        }
                    }header: {
                        Text ("Name")
                    }
                    
                    Section {
                        Text ("\(user.wrappedAge)")
                    }header: {
                        Text ("Age")
                    }
                    
                    Section {
                        Text (user.wrappedCompany)
                    }header: {
                        Text ("Company")
                    }
                    
                    Section {
                        Text (String(user.isActive))
                    }header: {
                        Text ("is Activity")
                    }
                    
                    Section {
                        Text ("\(user.wrappedDate.formatted(date: .numeric, time: .shortened))")
                    }header: {
                        Text ("Date of registration")
                    }
                    
                    Section {
                        Text(user.wrappedTags)
                            .font(.footnote)
                    }header: {
                        Text("Tags")
                    }
                    
                    
                    Section {
                        Toggle(isOn: $isShowFriendList) {
                            Text("to show friends")
                        }
                    }header: {
                        Text ("Switch to show friends")
                    }
                    
                    if isShowFriendList {
                        Section {
                            NavigationLink {
                                FriendsListView(friends: self.user.friendsArray)
                            }label: {
                                Text("Show \(user.wrappedName)'s friends")
                            }
                        }header: {
                            Text ("User`s friends list")
                        }
                    }
                    
                    
                    
                }
            
            
            .navigationTitle("Details on \(user.wrappedName)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
