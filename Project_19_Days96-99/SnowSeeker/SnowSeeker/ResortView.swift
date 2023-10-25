//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Михаил Тихомиров on 14.10.2023.
//

import SwiftUI

struct ResortView: View {
    
    let resort: Resort
    
    var body: some View {
        ScrollView{
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    Image (decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    HStack {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                    .padding(.vertical)
                    .background(Color.primary.opacity(0.1))
                    
                    Group {
                        Text(resort.description)
                            .padding(.vertical)
                        
                        Text ("Facilities")
                            .font(.headline)
                        
                        Text(resort.facilities, format: .list(type: .and)) // with help of this code we get sequence in a list format with "and" mention at the end
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ResortView(resort: Resort.example)
        }
    }
}
