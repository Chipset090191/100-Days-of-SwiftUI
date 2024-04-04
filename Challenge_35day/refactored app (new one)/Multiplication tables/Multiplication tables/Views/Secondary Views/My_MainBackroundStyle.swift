//
//  Background.swift
//  Multiplication tables
//
//  Created by Михаил Тихомиров on 19.03.2024.
//

import SwiftUI

struct My_MainBackroundStyle: View {
    var body: some View {
        AngularGradient(gradient: 
                        Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
                        center: .center)
            .ignoresSafeArea()
            .blur(radius: 10)
    }
}

#Preview {
    My_MainBackroundStyle()
}
