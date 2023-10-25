import Cocoa

//var numbers = [1,2,3]
//numbers.append(4)
//
//if numbers.count > 3 {
//    numbers.remove(at: 0)   // remove element from explicit position and return that element
//
//}
//print (numbers)
//
//let username = "Canada"
//
//print (username.count)
//
//let name = "Taylor"
//
//if name == "Paulol" {
//    print ("ok")
//}



// switch

// we can use enum into switch construction

enum weather {
    case sun,wind,breezy
}

//let forecast = weather.sun
//
//
//switch forecast {
//case .sun:
//    print("sun")
//case .wind:
//    print("wind")
//default:
//    print ("nothing")
//}


//let place = "Metropolis"
//
//switch place {
//case "Gotham":
//    print ("Batman")
//default:
//    print ("-")
//}

//let day = 5
//print ("My true love gave to me")
//
//switch day {
//case 5:
//    print ("5 golden rings")
//    fallthrough                     // with this operator we could easley go to with an option down
//case 4:
//    print ("4 calling birds")
//default: break
//}


// ternary operators

let age = 18
let canvote = age >= 18 ? "Yes" : "No"

print (canvote)

let hour = 23

print (hour < 12 ? "It`s before noon" : "It`s after noon")  // we can use ternary in other constructions such as print!

let names = ["Jayne", "Kaylee", "Mal"]
let crewCount = names.isEmpty ? "true":"false"


enum Theme {
    case light,dark
}

let theme = Theme.dark

let backgorund = (theme == .dark) ? "black":"white"



