//
//  MarksView.swift
//  HotProspects
//
//  Created by Михаил Тихомиров on 03.09.2023.
//

import SwiftUI

struct MarksView: View {
    
    let isContacted: Bool
    
    var body: some View {
        Image(systemName: isContacted ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark")
            .font(.title)
            .foregroundColor( isContacted ? .green : .blue)
//        Label(, systemImage: isContacted ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark")
//            .font(.title)
    }
}

//struct MarksView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarksView()
//    }
//}
