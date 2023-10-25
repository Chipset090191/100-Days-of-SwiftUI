import Cocoa

struct Car {
    let Model:String
    let Number_of_Seats:Int
    private var Current_Gear = 1
    
    init(Model:String, Number_of_Seats:Int) {
        self.Model = Model
        self.Number_of_Seats = Number_of_Seats
    }
    
    mutating func Change_Gear (gear:Int) {
        if Current_Gear < gear {
           Current_Gear = gear
           print ("The \(Model)'s car with a \(Number_of_Seats) seats is moving on \(Current_Gear) gear ")
        }else if Current_Gear > gear  {
           Current_Gear = gear
           print ("The \(Model)'s car with a \(Number_of_Seats) seats is moving on \(Current_Gear) gear ")
        }else {
           print ("The same gear! Change up or down!")
        }
    }
    
}

var car1 = Car(Model: "Tesla", Number_of_Seats: 4)
car1.Change_Gear(gear: 1)
car1.Change_Gear(gear: 2)
car1.Change_Gear(gear: 1)







