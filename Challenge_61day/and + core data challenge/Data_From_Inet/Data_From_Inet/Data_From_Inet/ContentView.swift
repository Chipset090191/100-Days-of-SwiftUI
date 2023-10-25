//
//  ContentView.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 06.07.2023. With a help of PetroOnishchuk!  https://github.com/PetroOnishchuk/100-Days-Of-SwiftUI.git. Got this code from there and added couple things!


import SwiftUI
import CoreData

struct ContentView: View {
    
    
    
    @Environment (\.managedObjectContext) var moc
    @FetchRequest(entity: CashedUser.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users:FetchedResults<CashedUser>
    
    
    
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(users, id: \.id) { user in
                    NavigationLink{
                        DetailUserView(userId: user.wrappedId)
                    }label: {
                        HStack{
                            VStack(alignment: .leading, spacing: nil){
                                Text(user.wrappedName)
                                    .font(.headline)
                                Text ("Age: \(user.age)")
                                    
                            }
                            Spacer()
                            Text(String(user.checkIsActive))
                                .font(.caption)
                                .foregroundColor(user.checkIsActive == "Active" ? .green : .secondary)
                                
                        }
                    }
                }
                .onDelete(perform: remove(at:))
            }
            .navigationTitle("Data from net")
        }
        .onAppear {
            if self.users.isEmpty {
                print ("Users is empty \(self.users)")
                Users.loadDataToCD(moc: moc)
            }
        }
    }
    
    func remove(at offsets:IndexSet) {
//        for index in offsets {
//            let user = users[index]
//            moc.delete(user)
//
//            do {
//                try moc.save()
//            }catch {
//                print ("Error save after delete")
//            }
//        }
        
        for all in users {
            moc.delete(all)
        }
        try? moc.save()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
