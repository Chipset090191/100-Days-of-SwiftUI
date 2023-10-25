import Cocoa

// default values

//func numbers(number1:Int, number2: Int=12){
//
//    number1 + number2
//
//}
//numbers(number1: 5)
//
//
//var characters = ["Lana", "Pam"]
//characters.removeAll(keepingCapacity: true)
////print (characters.count)
//
//
enum PasswordError:Error{
    case short,obvious
}


func checkPassword(_ password:String) throws -> String {
    if password.count < 5 {throw PasswordError.short}  // with THROW we interrupt next code and leave function
    if password == "12345" {throw PasswordError.obvious}
    return "Excellent"
}

let string = "123"

do {
    let result  = try checkPassword(string)
    print ("Password rating: \(result)")
} catch PasswordError.short {
    print ("Please use a longer password.")
} catch PasswordError.obvious {
    print ("make it difficult!")
}
catch {
    print ("There was an error.")
}


//or
//
//    let result  = try! checkPassword(string)   // if you strongly beleave that there cannot be an error at all
//    print ("Password rating: \(result)")

