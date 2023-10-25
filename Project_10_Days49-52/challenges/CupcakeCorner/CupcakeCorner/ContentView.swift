//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Михаил Тихомиров on 29.05.2023.
//

import SwiftUI


struct ContentView: View {
    @StateObject var our_class = Main_class()
   
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    Picker("Select your cake type", selection: $our_class.order.type) {
                        ForEach(Order.types.indices) {
                            Text (Order.types[$0]) // $0 it`s our index from indices
                        }
                    }
                    
                    
                    Stepper ("Number of cakes: \(our_class.order.quantity)", value:$our_class.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $our_class.order.specialRequestEnabled.animation())
                    
                    //specialRequestEnabled will show toggles with animation
                    if our_class.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $our_class.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $our_class.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink{
                        AddressView(our_class: our_class)
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
