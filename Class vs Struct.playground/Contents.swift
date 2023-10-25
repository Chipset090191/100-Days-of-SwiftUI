import UIKit

//class Car {
//    var year:Int
//    var make: String
//    var color:String
//
//    init(year:Int, make: String, color: String) {
//        self.year = year
//        self.make = make
//        self.color = color
//    }
//}
//
//
//var myCar = Car(year: 20200, make: "Porsche", color: "Grey")
//var stolenCar = myCar
//stolenCar.color = "Yellow"
//print(myCar.color)

struct Car {
    var year:Int
    var make: String
    var color:String
}

var myCar = Car(year: 2022, make: "Porsche", color: "Grey")
var stolnenCar = myCar
stolnenCar.color = "Red"
print(stolnenCar.color)
print(myCar.color)

