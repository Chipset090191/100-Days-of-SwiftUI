//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Михаил Тихомиров on 26.09.2023.
//

import SwiftUI


struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                        // MARK: CHALLENGE #3
                            .background(Color(hue: (Double(index) * 2) / 100, saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                        // MARK: CHALLENGE #1.
                            .opacity((Double(index) * 2) / 100)
                        // MARK: CHALLENGE #2.
                            .scaleEffect(((Double(index) * 2) / 100) < 0.5 ? 0.5 : (Double(index) * 2) / 100)
                    }
                    .frame(height: 40)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
