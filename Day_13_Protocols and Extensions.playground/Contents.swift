import Cocoa

// how to create and use protocols

protocol Vehicle {
    var name:String { get }
    var currentPassengers: Int { get set }
    func estimateTime (for distance:Int) -> Int
    
    func travel (distance:Int)
}



struct Car: Vehicle {
    var sector = "Tesla"
    var name:String {
        if sector == "Tesla" {
            return "Tesla x"
        }
        return "Mark"
    }
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print ("I`m driving \(distance) km")
        
    }

    
    // it`s new right into in struct!
    func openSunroof() {
        print ("It`s a nice day!")
    }
}





struct Bicycle: Vehicle {
    var name = "Bicycle"
    var currentPassengers = 1
    
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) {
        print ("I`m cycling \(distance) km")
    }
    
    
}



func commute (distance:Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print ("That`s too slow! I`ll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

// we can even use protocol as type for Array!
func getTravelEstimates(using vehicles: [Vehicle], distance:Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print ("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
    
}


let car = Car()

print (car.name)
commute(distance: 100, using: car)



let bike = Bicycle()
commute(distance: 50, using: bike)

getTravelEstimates(using: [car, bike], distance: 150)


// opaque return types



func getRandomNumber () -> some Equatable {
    Int.random(in: 1...6)
}


func getRandomBool() ->some Equatable {
    Bool.random()
}

print (getRandomNumber() == getRandomNumber())

print ("--------")

let num = getRandomNumber()


// Extensions

var quote = "   The truth is rarely pure and never simple   "
//let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

//extension String {
//    func trimmed() -> String {
//        self.trimmingCharacters(in: .whitespacesAndNewlines)
//    }
//}




//let trimmed = quote.trimmed()


extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    // func must be mutating if we try assigning smth to SELF!
    mutating func trim() {
        self = self.trimmed()
    }
    
    var lines:[String] {
        return self.components(separatedBy: .newlines)
    }
}


quote.trimmed()

let lyrics = """
But I keep cruising
Can`t stop, won`t stop moving
It`s like I got this music in my mind
Saying it`s gonna be alright
"""

print (lyrics.lines)



//
//mutating func trim() {
//    self = self.trimmed()
//}
//
//func trimmed () -> String {
//    self.trimmingCharacters(in: .whitespacesAndNewlines)
//}

print ("---------")


// how to create and use protocol extensions

extension Collection {    // instead of Array we can Use the key word Collection
    var isNotEmpty:Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty {
    print ("Guests count: \(guests.count)")
    
}

protocol Person {
    var name:String { get }
    func sayHello()
}


extension Person {
    func sayHello() {
        print ("Hi, I`m \(name)")
    }
}

struct Employee: Person {
    let name: String
    
    // And now we don`t need to use sayHell () cause that`s a extension of protocol Person!
    
}

let taylor = Employee(name: "Taylor")
taylor.sayHello()
