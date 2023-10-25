import Cocoa


for i in 1...100 {
    if i.isMultiple(of: 3) && !i.isMultiple(of: 5)  {
        print ("Fizz - \(i)")
    }else if i.isMultiple(of: 5) && !i.isMultiple(of: 3){
        print ("Buzz - \(i)")
    }else if  i.isMultiple(of: 3) && i.isMultiple(of: 5){
        print ("FizzBuzz - \(i)")
    }else {
        print ("just number - \(i)")
    }
}
