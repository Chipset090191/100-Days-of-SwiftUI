//
//  DetailUserView.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 13.07.2023.
//

import SwiftUI

struct DetailUserView: View {
    
    
    var fetchRequest: FetchRequest<CashedUser>
    var user:CashedUser? {
        fetchRequest.wrappedValue.first
    }
    
    var body: some View {
        UserView(user: user!)
    }
    
    init(userId:String) {
        self.fetchRequest = FetchRequest<CashedUser>(entity: CashedUser.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "id", userId))
    }
}

//struct DetailUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailUserView()
//    }
//}
