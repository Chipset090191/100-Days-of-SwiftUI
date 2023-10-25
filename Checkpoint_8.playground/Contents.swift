import Cocoa


extension String {
    mutating func symb_dollar() {
        self = self + "$"
    }
}

extension String {
    func symb_ruble() {
        "rubles"
    }
}

protocol Building {
    var count_of_rooms:Int { get set }
    var cost_of_estate:Int { get set }
    var name_of_estate:String { get }
    
   
    
}

struct House:Building {
 
    
    var name_of_estate: String
    
    var cost_of_estate: Int
    
    var count_of_rooms: Int
    
    
}


struct Office:Building {

    
    
    var name_of_estate: String
    
    var cost_of_estate: Int
    
    var count_of_rooms: Int
    
    
}

func Sales_Review(building:Building) {

    
    print("""
          Information about this building:
          Name of estate - \(building.name_of_estate);
          Count of rooms - \(building.count_of_rooms);
          Cost of estate - \(building.cost_of_estate);
          """)
}

let office = Office(name_of_estate: "Tander", cost_of_estate: 2_000_000_000, count_of_rooms: 1370)
Sales_Review(building: office)
let house = House(name_of_estate: "Home_Sweet_home", cost_of_estate: 5_000_000, count_of_rooms: 5)
Sales_Review(building: house)



