//
//  User.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 06.07.2023.
//

import Foundation
import SwiftUI




struct User:Codable,Identifiable {
    var  id:String?
    var name:String?
    var age:Int
    var company:String?
    var isActive:Bool
    var registered:Date
    var tags = [String]()
    var friends:[Friend]
}

struct Friend:Codable,Identifiable {
    var id:String?
    var name:String?
}


