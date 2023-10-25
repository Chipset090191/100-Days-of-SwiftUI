//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Михаил Тихомиров on 29.05.2023.
//

import SwiftUI


struct ContentView: View {
    @StateObject var order = Order()
   
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text (Order.types[$0]) // $0 it`s our index from indices
                        }
                    }
                    
                    
                    Stepper ("Number of cakes: \(order.quantity)", value:$order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                    
                    //specialRequestEnabled will show toggles with animation
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink{
                        AddressView(order: order)
                    }label: {
                        Text ("Delivery details")
                    }
                }
                
            }
            .navigationTitle("Cupcake Corner")
        }
    }
    
    
}
    
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
