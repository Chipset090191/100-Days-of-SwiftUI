import Cocoa

enum SqrtError:Error {
    case no_root
    case out_of_bounds
}

func square_root (X:Int, limit:Int = 100) throws {
    var sq_rt:Bool = false
    if X < 1 || X > 10000 {throw SqrtError.out_of_bounds}
    for index in (1...limit) {
        if X / index == index {
            print ("The square root is - \(index)")
            sq_rt = true
        }
    }
    if !sq_rt {throw SqrtError.no_root}
}

do {
    try square_root(X: 8)
} catch SqrtError.out_of_bounds {
    print ("Your value is out of range!")
} catch SqrtError.no_root {
    print ("Cannot find the square root!")
}

//square_root(X: 16)

