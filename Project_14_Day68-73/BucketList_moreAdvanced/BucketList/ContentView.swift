//
//  ContentView.swift
//  BucketList
//
//  Created by Михаил Тихомиров on 27.07.2023.
//


import SwiftUI
import MapKit


struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()   // we`ve put that instead of our properties that is`s been moved to ViewModel
    
    // MARK: changed that place1 to ViewModel
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    // instead of using MapMarker we are gonna use MapAnnotation
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.fill")
                            
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)  // 44 - that`s a magic number. Reccomended minimum number for size  for Apple
                                .background(.black)
                                .clipShape(Circle())
                            
                            
                            Text (location.name)
                                .fixedSize()  // we are sure our text won`t be shortened no matter how big it is
                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                // that`s our central point on the map
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            
                            // MARK: changed that place2 to ViewModel
                            // we call just the method here
                            viewModel.addLocation()
                            
                        }label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                                
                        }
                        
                        
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in   // place here is unwrapped version. Attention!
                EditView(location: place) { newLocation in
                    // MARK: changed that place3 to ViewModel
                    viewModel.update(location: newLocation)
                }
            }
            
            
        } else {
            // button here
            Button ("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert("Secure info", isPresented: $viewModel.showingAlert) {
                Button("Cancel", role: .cancel) {}
            }message: {
                Text(viewModel.message)
            }
            
        }
        
            
        
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
