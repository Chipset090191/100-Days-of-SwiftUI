import Cocoa

struct BankAccount {
    private var funds = 0
    
    
    mutating func deposit (amount:Int) {
        funds += amount
    }
    
    mutating func withdraw (amount:Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        }else {
            return false
        }
    }
}
 
var account = BankAccount()
account.deposit(amount: 100)

let success = account.withdraw(amount: 200)

if success {
    print ("success")
}else{
    print ("not success ")
}

//account.funds -= 1000
//print (account.funds)
//
//


struct Doctor {
    var name:String
    private var currentPatient = "No one" // we cannot do smht like that!
    init(name:String) {
        self.name = name
//        self.currentPatient = "No one"  // but if we initialize in init that works
    }
    
    
}

let dr = Doctor(name:"Diablo")


// static properties and methods


struct School {
    static var studentCount = 0    // static - means the variable belongs to the struct
    
    
    static func add (student:String) {   // we don`t need to use mutating key word!
        
        print ("\(student) joined the school")
        studentCount += 1
    }
}
School.add(student: "Taylor")
print (School.studentCount)


struct AppData {
    static let version = "1.3 beta"
    static let saveFilename = "settings.json"
    static let homeURL = "https://hackingSwift"
}

AppData.version


struct test1 {
    static var population = 0
    
    
    init(pop:Bool) {
        if pop {
            test1.population = 500
        }
    }
}



struct Example1 {
    var name:String
}
var example1 = Example1(name: "Hi")
example1.name = "ten"





