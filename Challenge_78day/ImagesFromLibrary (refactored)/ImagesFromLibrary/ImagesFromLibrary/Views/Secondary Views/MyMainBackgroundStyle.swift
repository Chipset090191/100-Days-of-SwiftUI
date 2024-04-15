//
//  MyMainBackgroundStyle.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 07.04.2024.
//

import SwiftUI

struct MyMainBackgroundStyle: View {
    var body: some View {
        LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .white, location: 0.15),Gradient.Stop(color: .secondary, location: 0.99)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    MyMainBackgroundStyle()
}
