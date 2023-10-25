import Cocoa

//class Game {
//    var score = 0 {
//        didSet {
//         print ("Score is now \(score)")
//        }
//    }
//}
//var newGame = Game()
//newGame.score = 5



// inheritance

class Employee {
    let hours:Int
    
    init (hours:Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print ("I work \(hours) hours a day.")
    }
}

final class Developer:Employee {    // final - that prohibits inheritance from Developer!
    func work() {
        print ("I`m writing code for \(hours) hours.")
    }
    
    override func printSummary() {
        print ("I`m a developer who will sometimes work \(hours) hours a day, but other times will spend hours arguing about development.")
    }
}



let developer = Developer(hours: 15)
developer.printSummary()


// How to add initializers for classes
class Vehicle {
    let isElectric:Bool
    
    init(isElectric:Bool) {
        self.isElectric = isElectric
    }
}


class Car:Vehicle {
    let isConvertible:Bool
    
    init (isElectric:Bool, isConvertible:Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }

}

let teslaX = Car(isElectric: true, isConvertible: false)



//  Copying onjects/

class User {
    var username = "Anonymous"
    
    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
    
}

var user1 = User()
var user2 = user1.copy()
user2.username = "Taylor"

print (user1.username)
print (user2.username)


class Starship {
    var maxWarp = 9
}

var voyager = Starship()
voyager.maxWarp = 10
var enterprise = voyager
enterprise.maxWarp = 8
print (voyager.maxWarp)
print (enterprise.maxWarp)


// deinitializer

class User1 {
    let id:Int
    
    init(id:Int) {
        self.id = id
        print ("User \(id): I`m alive!")
    }
    
    deinit {
        print ("User \(id): I`m dead!")
    }
}

let user11 = User1(id: 1)


// variables inside classes !!!


class Userr {
    var name = "Paul"
}

var userr11 = Userr()
userr11.name = "Taylor"
//print (userr11.name)
user


