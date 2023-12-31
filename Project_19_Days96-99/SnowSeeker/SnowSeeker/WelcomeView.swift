//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Михаил Тихомиров on 14.10.2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text ("Please select a resort from the left-hand menu; swipe from left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
