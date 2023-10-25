import Cocoa

let sayHello = {(name:String)->String in
    "Hi \(name)!"
}
 
//print (sayHello("Taylor"))


let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]


let reverseTeam1 = team.sorted {$0 > $1}

print (reverseTeam1)

let tOnly1 = team.filter {$0.hasPrefix("T")}
print (tOnly1)

let uppercaseTeam1 = team.map {$0.uppercased()}
print (uppercaseTeam1)


func captainFirtsSorted(name1:String, name2:String)-> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name1 < name2
}



//let captainTeam = team.sorted(by: captainFirtsSorted)


//let captainFirstTeam = team.sorted(by: {(name1:String, name2:String) ->Bool in
//    if name1 == "Suzanne" {
//        return true
//    } else if name2 == "Suzanne" {
//        return false
//    }
//
//    return name1 < name2
//})
//print (captainFirstTeam)


let learSwift = {
    print("Closures")
}
learSwift()


var pickFruit = { (name:String) in
    switch name {
    case "strawberry":
        print ("strawberry")
    default:
        print ("default")
    }
}
pickFruit("strawberry")



let calculateResult = { (answer: Double) in
    if answer == 42 {
        print ("jd")
    }
    
}

calculateResult(42)

print (5)

// trailing closures


let captainFirstTeam = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    
    return $0 < $1
}
print (captainFirstTeam)

//let reverseTeam = team.sorted {
//    return $0 > $1
//}

let reverseTeam = team.sorted {$0 > $1}

print (reverseTeam)

let tOnly = team.filter {$0.hasPrefix("T")}
print (tOnly)

let uppercaseTeam = team.map {$0.uppercased()}
print (uppercaseTeam)


func pr (a:Int, b:Int)->Int {
    a + b
}
pr(a: 5, b: 6)


func makeArray (size:Int, using generator:() -> Int)-> [Int] {
    var numbers = [Int]()
    
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    
    return numbers
}


// you can use both approaches

func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 10, using: generateNumber)
print (newRolls)

let rolls = makeArray (size: 3) {
    Int.random(in: 1...20)
}
print (rolls)


func doImportantWork(first:() -> Void, second: ()->Void, third:()->Void) {
    print ("About to start first work")
    first()
    print ("About to start second work")
    second()
    print ("About to start third work")
    third()
    print ("Done!")
}

doImportantWork {
    print ("This is the first work")
} second: {
    print ("This is the second work")
} third: {
    print ("This is the third work")
}


var playWithDog = {
    print ("FDF")
}
playWithDog()

let awesomeTalk = {
    print ("Here")
}

func deliverTalk (name:String, type: () -> Void) {
    print ("inside")
    type()
}

var goOnBike = {
    print ("HI")
}
func race (using vehicleType: () -> Void ) {
    print ("Lets do")
    vehicleType()
}


let resignation = {(name: String) in
        print ("\(name)")
}


func printdoc(contents:(_ name:String)-> Void) {
    contents("Michael is the best!")
}



printdoc(contents: resignation)


let driveSafely = {
    return "I`m being a considerate driver"
}


func holdClass (name:String, lesson: () -> Void) {
    print ("\(name)")
    lesson()
}

holdClass(name: "Philosophy") {
    print ("HI")
}

func tendGarden(activities:()->Void, tets:()->Void){
    print ("I love gardening")
    activities()
}




    


