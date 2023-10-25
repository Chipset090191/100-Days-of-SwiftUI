import Cocoa

//annotations types

let surname = "Lasso"
var score:Float = 0.3

var books = Set([
    "Harry Potter",
    "Lord of the Rings"
])

var books1: Set<String> = Set([]) // empty set

var soda: [String] = ["Coke"]
var soda1: [String] = [String]()
var soda3: [String] = []
var clues = [String]()


enum UIStyle {
    case light, dark, system
}

var style: UIStyle = UIStyle.light

style = .dark

var sales: Double = 100_000


let albums = ["Red", "Fearless"]

let s = Set(arrayLiteral: albums)
print (s)

let new_set = Set(["luna"])


