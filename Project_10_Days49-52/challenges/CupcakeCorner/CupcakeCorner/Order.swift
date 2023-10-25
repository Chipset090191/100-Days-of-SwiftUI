//
//  Order.swift
//  CupcakeCorner
//
//  Created by Михаил Тихомиров on 01.06.2023.
//

import SwiftUI

    
    struct Order:Codable {
//        enum CodingKeys:CodingKey {
//            case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//        }
        
        
        static let  types = ["Vanila", "Strawberry", "Chocolate", "Rainbow"]
        
        var type = 0
        var quantity = 3
        
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        
        // the check for valid data
        var hasValidAddress:Bool {
            if (name.isEmpty || name == " ") || (streetAddress.isEmpty || streetAddress == " ") || (city.isEmpty || city == " ") || (zip.isEmpty || zip == "") {
                return false
            }
            return true
        }
        
        var cost: Double {
            // $2 per cake
            var cost = Double(quantity) * 2
            
            // complicated cakes cost more
            cost += (Double(type) / 2)
            
            // $1/cake for extra frosting
            if extraFrosting {
                cost += Double(quantity)
            }
            
            //$0.50 / cake for sprinkles
            if addSprinkles {
                cost += Double(quantity) / 2
            }
            
            return cost
        }
        
//        init() {}     // we added this init() without data because of required init from decoder
        
//        func encode(to encoder: Encoder) throws {
//            var container = encoder.container(keyedBy: CodingKeys.self)
//
//
//            try container.encode(type, forKey: .type)
//            try container.encode(quantity, forKey: .quantity)
//
//            try container.encode(extraFrosting, forKey: .extraFrosting)
//            try container.encode(addSprinkles, forKey: .addSprinkles)
//
//            try container.encode(name, forKey: .name)
//            try container.encode(streetAddress, forKey: .streetAddress)
//            try container.encode(city, forKey: .city)
//            try container.encode(zip, forKey: .zip)
//        }
        
        
        
//        required init(from decoder: Decoder) throws {
//
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            type = try container.decode(Int.self, forKey: .type)
//            quantity = try container.decode(Int.self, forKey: .quantity)
//
//            extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//            addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//            name = try container.decode(String.self, forKey: .name)
//            streetAddress = try container.decode(String.self, forKey: .streetAddress)
//            city = try container.decode(String.self, forKey: .city)
//            zip = try container.decode(String.self, forKey: .zip)
//
//        }
        
    }
    



