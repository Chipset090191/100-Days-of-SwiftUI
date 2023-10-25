//
//  CashedFriend+CoreDataProperties.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 12.07.2023.
//
//

import Foundation
import CoreData


extension CashedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CashedFriend> {
        return NSFetchRequest<CashedFriend>(entityName: "CashedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CashedUser?
    
    
    public var wrappedId:String {
        id ?? "Unknown"
    }
    
    public var wrappedName:String {
        name ?? "Unknown"
    }

}

extension CashedFriend : Identifiable {

}
