import Cocoa

var arr_num:[Int]?

func f1(numbers:[Int]?)->Int {
    return numbers?.randomElement() ?? Int.random(in: 1...100)
}



print (f1(numbers:nil))


