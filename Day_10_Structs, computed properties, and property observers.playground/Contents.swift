import Cocoa

struct Album {
    let title:String
    let artist:String
    let year:Int
    
    func printSummary() {
        print ("\(title) (\(year)) by \(artist)")
    }
}



let red = Album(title: "Red", artist: "Taylor", year: 2012)

red.printSummary()

struct Employee {
    let name:String
    var vacationRemaining:Int
    
    mutating func takeVacation(days:Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print ("I`m going on vacation!")
            print ("Days remaining: \(vacationRemaining)")
        } else {
            print ("Ooops! There aren`t enough days remaining")
            print ("\(name)")
        }
    }
    
}

//var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
//archer.takeVacation(days: 5)
//print (archer.vacationRemaining)
//



//

struct Employee1 {
    var vacationAllocated:Int = 20
    var vacationTaken = 0
    
    var vacationRemaining:Int {
        get{
                vacationAllocated - vacationTaken
        }
        set {
            vacationAllocated = vacationTaken + newValue  // we can use newValue to pass the value in set!
        }
    }
}

var Arch = Employee1()
Arch.vacationTaken += 4
print (Arch.vacationRemaining)
Arch.vacationRemaining = 5
print (Arch.vacationAllocated)




    
struct Sung {
    var protectionLevel:Int
    var Vision:String {
        get {
            if protectionLevel < 3 {
                return "That`s not enough"
            }
            return "That`s ok!"
        }
        
    }
}

var c = Sung(protectionLevel: 15)



// how to create custom initializers

struct Player {
    let name:String
    let number:Int
    
    
    init (name:String, number:Int) {
        self.name = name
        self.number = number
    }
}

let player = Player(name:"Megan", number:15)



struct Dictionary {
    var s = Set<String>()
}
let dictionary = Dictionary()
print (dictionary.s)


// property observers


struct Game {
    var score = 0 {
        didSet {
            print ("score is now \(score)")
        }
    }
    
    
    
    
    
}

//var game = Game()
//game.score += 10
//game.score -= 3

//struct App {
//    var contacts = [String]() {
//        willSet {
//            print ("Current value is: \(contacts)")
//            print ("New value will be: \(newValue)")
//        }
//
//        didSet {
//            print ("There are now \(contacts.count) contacts")
//            print ("Old value was: \(oldValue)")
//        }
//    }
//}
//
//var app = App()
//app.contacts.append("Adrian E")
//app.contacts.append("Allen W")


// how to create custom initializers

struct Player1 {
    let name:String
    let number:Int
    
    init (name1:String, number1:Int) {
        name = name1
        number = number1
    }
    
}

let player1 = Player1(name1: "Megan", number1: 15)


