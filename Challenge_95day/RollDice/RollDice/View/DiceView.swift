//
//  DiceView.swift
//  RollDice
//
//  Created by Михаил Тихомиров on 08.10.2023.
//

import SwiftUI



struct DiceView: View {
    @State private var line_Width = 5.0
    
    var body: some View {
        Image("cube")
            .resizable()
            .scaledToFit()
            .frame(width: 110, height: 110)
        
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
