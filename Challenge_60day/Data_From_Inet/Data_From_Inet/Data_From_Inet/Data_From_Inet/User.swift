//
//  User.swift
//  Data_From_Inet
//
//  Created by Михаил Тихомиров on 06.07.2023.
//

import Foundation
import SwiftUI




struct User:Codable,Identifiable {
    let id:String
    let name:String
    let age:Int
    let company:String
    let isActive:Bool
    let registered:Date
    let address:String
    let about:String
    let friends:[Friend]
}

struct Friend:Codable,Identifiable {
    let id:String
    let name:String
}


