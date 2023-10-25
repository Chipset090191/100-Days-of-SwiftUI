//
//  Resort.swift
//  SnowSeeker
//
//  Created by Михаил Тихомиров on 12.10.2023.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")  // we use the Bundle extension to get access to our resorts.json and then create a static example for our app
    static let example = allResorts[0]
    
    
    
    // or instead two lines above we can use this code:
    //  static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
}


