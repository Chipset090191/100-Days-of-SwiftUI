//
//  ContentView.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 07.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    let List = [
        GridItem(.adaptive(minimum: 200))
    ]

    var body: some View {
        NavigationView {
            ZStack{
                MyMainBackgroundStyle()
                ScrollView{
                    LazyVGrid(columns: List) {
                        ForEach(viewModel.pictures, id: \.id) { item in
                            NavigationLink {
                                DetailScreen(picture: item) { uuid, newName, statusForDelete in
                                    viewModel.CheckingDSUpdates(uuid: uuid, newName: newName, statusForDelete: statusForDelete)
                                }
                                
                            } label: {
                                VStack {
                                    
                                    Spacer()
                                    item.image()?
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 270, height: 170)
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                        
                                    Spacer ()
                                    
                                    Text ("Name of Photo: \(item.PicName)")
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
            }
            .preferredColorScheme(.light)
            .navigationTitle("Mapped images")
            .onAppear {
                    viewModel.Initialization()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showingAddPhoto = true
                    }label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
            .sheet(isPresented: $viewModel.showingAddPhoto) {
                AddPhoto(pictures: $viewModel.pictures)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
