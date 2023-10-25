//
//  ContentView.swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 13.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    

    
    let List = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: List) {
                    ForEach(viewModel.presentationOfImage) { element in
                        
                            NavigationLink {
                                // my code
                                DetailScreen(image: element.image, imagedata: element.imagedata, name: element.filename, key: "e") {onSave , onAppeaR in
                                    viewModel.update(current_element: element, elementOnSave: onSave, elementOnAppear: onAppeaR)
                                }
                            } label: {
                                VStack(spacing: 0) {
                                    element.image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 220, height: 220)
                                    

                                        Text ("Photo`s name: \(element.filename)")
                                        .foregroundColor(.black)
                                        .font(.caption)
                                            .italic()
                                    
                                   
                                            
                                }
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay (
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.secondary)
                                )
                      
                        }
                    }
                    
                }
            }
            
            .navigationTitle("Images")
            .toolbar{
                    Button{
                        viewModel.showingImagePicker = true
                    }label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
            }
            
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.pickedImage()
                viewModel.showingPreviewDialog = true
            }
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .sheet(isPresented: $viewModel.showingPreviewDialog) {
                DetailScreen(image: viewModel.image!, imagedata: viewModel.imagedata!, name: viewModel.name, key: "c") { onSave, onAppeaR in
                            viewModel.addition(elementOnSave: onSave, elementOnAppear: onAppeaR)
                        }
                }
                
        }
        
    }
    

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
