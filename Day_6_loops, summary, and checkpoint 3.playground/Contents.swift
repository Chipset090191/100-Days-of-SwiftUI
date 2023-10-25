import Cocoa

//// loops
//
//for i in 1..<5{ // it`s from 1 to up 5 (not include 5)
////    print (i)
//}
//
//var lyric = "Haters"
//
//for _ in 1...5 {   // we can use underscore
//    lyric+=" hate"
//}
////print (lyric)
//
//
//let filenames = ["me.jpg","work.txt","sophie.jpg"]
//
//for filename in filenames {
//    if filename.hasSuffix(".jpg") == false {
//        continue                                    // this operator skip iteration in loop
////        break                                       // whereas BREAK skip current iteration and others
//    }
////    print ("\(filename)")
//}
//
//
//let n = 2 % 10
//print (n)
//
//
//
//for name1 in ["Jonh","Samantha"] {
//
//}
//
//while true {
//    print ("Hi")
//
//}

//
//for i in 1...100 {
//
//    if i.isMultiple(of: 3) {
//        print ("Fizz")
//    }else if i.isMultiple(of: 5) {
//        print ("Buzz")
//    }if i.isMultiple(of: 3) {
//        print ("Fizz")
//    }
//
//}

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



