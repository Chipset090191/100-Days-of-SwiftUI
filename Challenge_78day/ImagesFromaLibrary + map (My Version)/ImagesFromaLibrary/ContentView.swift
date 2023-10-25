//
//  ContentView.swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 13.08.2023.
//

import SwiftUI
import MapKit
struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    
    
    

    
    let List = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .white, location: 0.15),Gradient.Stop(color: .secondary, location: 0.99)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                ScrollView{
                    LazyVGrid(columns: List) {
                        ForEach(viewModel.presentationOfImage) { element in
                            
                            NavigationLink {
                                // my code
                                DetailScreen(del: $viewModel.del, image: element.image, imagedata: element.imagedata, name: element.filename, key: "e", uuid: element.id, coordinateRegion: MKCoordinateRegion(center: element.coordinate, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)) ) {onSave , onAppeaR in
                                    viewModel.update(current_element: element, elementOnSave: onSave, elementOnAppear: onAppeaR)
                                }
                            } label: {
                                VStack(spacing: 0) {
                                    Spacer()
                                    
                                    element.image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 270, height: 170)
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                    
                                    Spacer ()
                                    
                                    Text ("Photo`s name: \(element.filename)")
                                        .foregroundColor(.black)
                                        .font(.caption)
                                        .italic()
                                    
                                    Spacer()
                                    
                                    
                                    
                                }
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay (
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.black, lineWidth: 3)
                                )
                                
                            }
                        }
                        
                        
                    }
                }
                .preferredColorScheme(.light)
            }
            
            .navigationTitle("Mapped images")
            .toolbar{
                

                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        viewModel.showingImagePicker = true
                        //here we start track our last location
                        self.viewModel.locationFetcher.start()
                    }label: {
                        Image(systemName: "plus")

                    }
                }
            }
            
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.pickedImage()
                
                // getting our current location
                viewModel.showingPreviewDialog = true
            }
            
            .onChange(of: viewModel.del, perform: { newValue in
                viewModel.delete(uuid: newValue)
            })
            
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .sheet(isPresented: $viewModel.showingPreviewDialog) {
                DetailScreen(del: $viewModel.del, image: viewModel.image!, imagedata: viewModel.imagedata!, name: viewModel.name, key: "c", uuid: UUID(), coordinateRegion: viewModel.map) { onSave, onAppeaR in
                            viewModel.addition(elementOnSave: onSave, elementOnAppear: onAppeaR)
                        }
                }
                
        }
        .onAppear{
            viewModel.authenticate()
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
