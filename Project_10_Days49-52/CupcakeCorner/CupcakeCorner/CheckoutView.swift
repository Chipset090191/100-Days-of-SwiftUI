//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Михаил Тихомиров on 02.06.2023.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    @State private var confitmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url:URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                       
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233) // to be sure enough that we get the customized height of our image!
                
                Text ("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {    // we use Task to force our button work with async!
                        await placeOrder()
                    }
                    
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button ("OK") {}
        }message: {
            Text (confitmationMessage)
        }
    }
    
    // to upload our order we`ve got to use async to the function
    func placeOrder() async {
        
        // the first step to encode the data we wanna send
        guard let encoded = try? JSONEncoder().encode(order) else {
            print ("Failed to encode order")
            return
        }
        
        // the second step is tell swift what kind of data we wanna send
        
        // Exclamation mark. the code will be crashed if that site is not real.
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        // we post information like json type to our application on web server
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // we then set our network request
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        
            // handle the result
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confitmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch{
            print ("Checkout failed.")
        }
        
        
        
        
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
