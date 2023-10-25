//
//  FriendsListView.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 13.07.2023.
//

import SwiftUI

struct FriendsListView: View {
    
    var friends:[CashedFriend]
    
    var body: some View {
        List() {
            ForEach(friends, id: \.wrappedId) { friend in
                NavigationLink {
                    DetailUserView(userId: friend.wrappedId)
                }label: {
                    VStack(alignment: .leading, spacing: nil) {
                        Text (friend.wrappedName)
                    }
                }
            }
        }
    }
}

//struct FriendsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendsListView()
//    }
//}
