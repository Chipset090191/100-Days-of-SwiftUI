import Cocoa

//func numbers (_ a:Int, _ b:Int) {
//    print(a + b)
//}
//
//numbers(5, 6)
//
//
//func readUserInput() {
//    while true {
//        print("read")
//        break
//    }
//}
//readUserInput()
//
//
//let ord = [1,2,3,4]
//
//var st:String = "mama"
//
//let first = st.sorted()
//
//
//func areLettersIdentical(string1:String, string2:String) ->Bool {
//
//    return string1.sorted() == string2.sorted()
//}
//
//areLettersIdentical(string1: "mams", string2: "mama")
//
//
//var srt = ""
//print (srt)


// dictionary

//func getUser() -> [String:String] {
//    ["firstName":"Taylor","lastName":"Swift"]       // we can use constraction without return
//
//}
//
//let user = getUser()
//
//print ("Name: \(user["firstName",default: "?"])")

//func numb() ->Int {
//    5 + 10
//}
//
//numb()



//tuples. That`s good to back multiple values by using tuples!

//func getUser() -> (firstName:String, lastName:String) {
////    (firstName:"Taylor", lastName:"Swift") or
//        ("Taylor","Swift")
//}


// or

//func getUser() -> (String, String) {
////    (firstName:"Taylor", lastName:"Swift") or
//        ("Taylor","Swift")
//}
//
//
//let user = getUser()
//print ("Name \(user.0) \(user.1) ")
//
//

func getUser() -> (firstName:String, lastName:String) {
    (firstName:"Taylor", lastName:"Swift")
}


//let (firstName, lastName) = getUser()   // with destructuring

let (firstName, _) = getUser()   // with destructuring
print (firstName)


let s:Set = ["beans", "bananas"]
print (s)


var product = ("Mac", 1995)


func county (dogs: [String]){
    
}

 


