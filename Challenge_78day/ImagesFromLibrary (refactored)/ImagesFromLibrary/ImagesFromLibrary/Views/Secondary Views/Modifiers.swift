//
//  Modifiers.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 08.04.2024.
//

import SwiftUI

struct DrawPlusButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.black.opacity(0.75))
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Circle())
            .padding()
    }
}



