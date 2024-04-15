//
//  DetailScreenBackground.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 10.04.2024.
//

import SwiftUI

struct DetailScreenBackground: View {
    var body: some View {
        LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .white, location: 0.15),Gradient.Stop(color: .blue, location: 0.99)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    DetailScreenBackground()
}
