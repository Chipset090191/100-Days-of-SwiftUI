//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Михаил Тихомиров on 01.06.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var our_class: Main_class
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $our_class.order.name)
                TextField("Stree address", text: $our_class.order.streetAddress)
                TextField("City", text: $our_class.order.city)
                TextField("Zip", text: $our_class.order.zip)
            }
            
            Section {
                NavigationLink{
                    CheckoutView(our_class: our_class)
                }label: {
                    Text("Check out")
                }
            }
            .disabled(our_class.order.hasValidAddress == false)
            
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline) // to make "Delivery details" smaller than first one
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(our_class: Main_class())
        }
    }
}
