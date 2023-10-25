//
//  Result.swift
//  BucketList
//
//  Created by Михаил Тихомиров on 01.08.2023.
//

import Foundation

struct Result:Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]   // - first param is a internal identifier and then page for Value
    
}

// we push the decodable data to this struct 
struct Page: Codable, Comparable {
 
    
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description : String {
        terms?["description"]?.first ?? "No further information"   // we try compute whether description is there or not
    }
    
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}



