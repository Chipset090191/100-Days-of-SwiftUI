import Cocoa

//var greeting = "Hello, playground"
//
////var ar = Array(1...3)
//var ar:[Int] = []
var beatles = ["Jonh", "Paul", "George", "Ringo"]
beatles.remove(at: 0)
print (beatles)





//
//beatles.append("Adrian")
//
//var scores = Array<Int>()
//scores.append(100)
//scores.append(80)
//scores.append(85)
//print (scores[1])
//
//
//print (beatles[0])
//
////var albums = [String]()
//var albums = ["Folklore"]
//
//print (beatles.count)
//
//beatles.remove(at: 2)
//print(beatles)
//
//print (beatles.contains("Jonh"))
//print (beatles.sorted())
//
//beatles.reversed()



// dictionaries

let employee2 = [
    "name":"Taylor Swift",
    "job":"Singer",
    "Location":"Nashville"
]

print (employee2["name", default: "Unknown"])

let classroom = [
    1:"Michael",
    2:"Igor"
]

//struct ast {
//    let name:String
//    let number:Int
//}
//
//
//let dic = [
//    "grisom":ast
//
//]



let hasGraduated = [
    "Eric":false,
    "Michael":true,
    "Otis":false,
]

var heights = [String:Int]()
heights["YaoMing"] = 223
heights["O`Neal"] = 225
heights["Lebron James"] = 206
heights["YaoMing"] = 223


print (heights)
heights.removeAll()
//
//let capitals = ["England":"London", "Wales":"Cardiff"]
//let scotlandCapital = capitals ["Scotland"]
////print (scotlandCapital)
//
//let abbreviations = ["m":"meters", "km": "kilometers"]
//let meters = abbreviations["m", default: "kl"]
//print(meters)



//// sets
//
//let actors = Set(["Denzel Washington","Tom Cruise","Nicolas Cage","Samuel L Jackson"])
//
////var actors = Set<String>()
////actors.insert("Denzel Washington")   // sets have no order that`s why we use insert instead append
//                                     // you can not put duplicates into sets!
////print (actors)
//
//var readings = Set ([true,false,true,true])  // this set holds just only two positions because of it cannot contain duplicates
//print (readings)



// enums

enum Weekday {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
}

var day = Weekday.Monday
day = .Friday

print (day)
