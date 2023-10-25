//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Михаил Тихомиров on 14.10.2023.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    // that`s for scaling
    @Environment (\.horizontalSizeClass) var sizeClass
    @Environment (\.dynamicTypeSize) var typeSize
    
    @EnvironmentObject var favorites: Favorites // Warning! For the Preview we inject the same thing
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView{
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    ZStack(alignment: .bottomTrailing){
                        Image (decorative: resort.id)
                            .resizable()
                            .scaledToFit()
                        Text("Photo by: \(resort.imageCredit)")
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(4)
                            .foregroundColor(.white)
                            .background(.black)
                            .clipShape(Capsule())
                            .offset(x: -5, y: -5)
                            .opacity(0.75)
                        
                    }
                    HStack {
                        if sizeClass == .compact && typeSize > .large {    // generally iphones have the compact size
                            VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                            VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                        } else {
                            ResortDetailsView(resort: resort)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .padding(.vertical)
                    .background(Color.primary.opacity(0.1))
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)  // optional step
                    
                    Group {
                        Text(resort.description)
                            .padding(.vertical)
                        
                        Text ("Facilities")
                            .font(.headline)
                        
//                        Text(resort.facilities, format: .list(type: .and)) // with help of this code we get sequence in a list format with "and" mention at the end
//                            .padding(.vertical)
                        
                        HStack {
                            ForEach(resort.facilityTypes) { facility in
                                Button {
                                    selectedFacility = facility
                                    showingFacility = true
                                } label: {
                                    facility.icon   // we convert each one to icon
                                        .font(.title)
                                }
                            }
                        }
                        
                        Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                            if favorites.contains(resort) {
                                favorites.remove(resort)
                            } else {
                                favorites.add(resort)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
            .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
               // here presenting - this is our object we present inside a closure, means we can work with this. But here we do not work with this and use just blank _ symbol
            }message: { facility in
                Text (facility.desscription)
            }
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ResortView(resort: Resort.example)
        }
        .environmentObject(Favorites())
    }
}
