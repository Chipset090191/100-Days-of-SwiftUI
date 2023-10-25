import Cocoa

// how to handle missing data with optionals

let opposites = ["Mario":"Vario","Luigi":"Waluigi"]
if let marioOpposite = opposites["Mario"] {
    print ("Mario`s opposite is \(marioOpposite)")
}


var username:String?


let favoriteTennisPlayer:String? = "Andy"


// unwrapping with GUARD




func printSquare(of number: Int?){
    guard let number = number else {
        print ("Missing number")
        return
    }
    print (number)
}

printSquare(of: 5)



var myVar:Int? = 3

//guard let unwrapped = myVar else {
//   print ("Yes")
//
//}


print ("----------------------------")

// unwrap oprionals with nil coalescing

let captains = ["Enterprise":"Picard"]

let cap = ["Eleonor","Arthur", "Macalister"]

//let new = captains["Serenity"] ?? "N/A"
let new = captains["Serenity", default: "N/A"]

let favorite = cap.randomElement() ?? "None"


struct Book {
    let title: String
    let author:String?
}

//let book = Book (title: "Beowulf", author: nil)
//let author = book.author ?? "Anonymous"

let input = ""
let number = Int (input) ?? 0

let distanceRan:Double? = 0.5
let distance:Double = distanceRan ?? 0

print ("----------------------------")

// optional chaining

let names = ["Area", "Robb","Sansa"]

let chosen = names.randomElement()?.uppercased() //   "method()?. + method() " it`s literally say us If an optional has a value run some code on that value!! (if the optional has a value then unwrap it and carry on)


var book: Book? = nil
let author = book?.author?.first?.uppercased() ?? "A"
print (author)


func loadForecast (for dayNumber:Int) -> String {
//    print ("Forecast unavailable.")
////    return
    return ""
}

print ("----------------------------")

// how to handle function failure with optionals

enum UserError:Error {
    case badID, networkFailed
}

func getUser(id:Int) throws -> String {
    if id == 23 {throw UserError.networkFailed}
    return "another"
}
var st:String?

if let user = try? getUser(id: 23) {
    print ("User: \(user)")
    st = user
}

let user = (try? getUser(id: 23)) ?? "Anonymous"


