//
//  User.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 04.07.2023.
//

import Foundation
import SwiftUI


struct User: Codable,Identifiable {
 
    let id:String
    let name:String
    let age:Int
    let address:String
    let about:String
    let company:String
    let isActive:Bool
    let friends:[Friend]
}

struct Friend:Codable,Identifiable {
    let id:String
    let name:String
}
