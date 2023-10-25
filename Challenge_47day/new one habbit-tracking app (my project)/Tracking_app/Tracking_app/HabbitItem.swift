//
//  HabbitItem.swift
//  Tracking_app
//
//  Created by Михаил Тихомиров on 25.05.2023.
//

import Foundation
struct HabbitItem: Codable, Identifiable,Equatable {
    let id = UUID() // UUID() - means it creates unique id automatically
    let name:String
    var description:String
    var amount:Int
}
