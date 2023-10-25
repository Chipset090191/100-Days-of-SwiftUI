//
//  CashedUser+CoreDataProperties.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 12.07.2023.
//
//

import Foundation
import CoreData


extension CashedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CashedUser> {
        return NSFetchRequest<CashedUser>(entityName: "CashedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    
    public var wrappedId:String {
        id ?? "Unknown"
    }
    
    public var wrappedName:String {
        name ?? "Unknown"
    }
    
    public var wrappedCompany:String {
        company ?? "Unknown"
    }
    
    public var wrappedAge:Int16 {
        age
    }
    
    public var wrappedIsActive:Bool {
        isActive
    }
    
    public var checkIsActive:String {
        return isActive ? "Active" : "not Active"
    }
    
    public var wrappedDate:Date {
        registered ?? Date.now
    }
    
    public var wrappedTags:String {
        tags ?? "Unknown"
    }
    
    public var friendsArray:[CashedFriend] {
        let set = friends as? Set<CashedFriend> ?? [] //( or after nil coalescing we get empty set) look at here // //https://www.hackingwithswift.com/books/ios-swiftui/one-to-many-relationships-with-core-data-swiftui-and-fetchrequest
        
        return set.sorted {
            $0.name! > $1.name!
        }
    }
    

}

// MARK: Generated accessors for friends
extension CashedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CashedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CashedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CashedUser : Identifiable {

}
