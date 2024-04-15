//
//  DetailScreen.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 10.04.2024.
//

import SwiftUI
import CoreLocation

struct DetailScreen: View {
    
    @Environment (\.dismiss) var dismiss
    
    @StateObject private var viewModel: DetailScreenModel

    
    var body: some View {
        ZStack {
                    DetailScreenBackground()
            VStack {
                
                Spacer()
                Spacer()
                Spacer()
                
                HStack {
                    TextField("name of photo", text: $viewModel.picture.PicName)
                        .italic()
                        .bold()
                        .padding(.vertical)
                        .background(Color.green)
                        .frame(width: 300, height:30, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(.black, lineWidth: 1))
                        .multilineTextAlignment(.center)
                        .opacity(viewModel.currentZoom >= 0.208 || viewModel.totalZoom >= 1.208 ? 0.05 : 1)
                        .animation(.default, value: viewModel.currentZoom)
                }
                
                    ZStack {
                        if viewModel.picture.image() != nil {
                            viewModel.picture.image()?
                                .resizable()
                                .scaledToFit()
                                .overlay(
                                    Rectangle()
                                        .stroke(lineWidth: 2)
                                )
                                .scaleEffect(viewModel.currentZoom + viewModel.totalZoom)
                                
                                .padding(.horizontal, 3)
                                .gesture(
                                    MagnifyGesture()
                                        .onChanged { value in
                                            viewModel.onChangeZoom(value: value.magnification)
                                        }
                                        .onEnded { _ in
                                            viewModel.onEndedZoom()
                                        }
                                )
                        } else {
                            Text ("Image not found")
                        }
                    }
                
                ZStack {
                    MapView(centerCoordinate: $viewModel.centerCoordinate, annotations: viewModel.picture.locations)
                        .clipShape(Capsule())
                        .shadow(radius: 10)
                        .overlay {
                            Capsule()
                                .stroke(.blue, lineWidth: 3).blur(radius: 1)
                        }
                    
                }
                .padding([.horizontal, .vertical])
                .ignoresSafeArea()
                .opacity(viewModel.currentZoom >= 0.208 || viewModel.totalZoom >= 1.208 ? 0.05 : 1)
                .animation(.default, value: viewModel.currentZoom)
            }
            .navigationTitle("Detail info")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onDisappear {
             // when we leave DetailView we put data to the back closure
            viewModel.onDismissDetailView(viewModel.picture.id, viewModel.picture.PicName, viewModel.picture.statusForDelete)
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button{
                        viewModel.showingActivityViewController = true
                        
                    } label: {
                        Label("Send", systemImage: "square.and.arrow.up")
                    }
                     
                    Button{
                        viewModel.showingAlertForDelete = true
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $viewModel.showingActivityViewController) {
            ActivityVIewController(activityItems: [viewModel.picture.PicName,viewModel.picture.UIimage() ?? "Picture wasn`t sent"])
        }
        .alert(isPresented: $viewModel.showingAlertForDelete) {
            Alert(title: Text("Deleting picture.."), message: Text("Do you want to delete: \"\(viewModel.picture.PicName)\"?"),
                  primaryButton:
                    .cancel(),
                  secondaryButton:
                    .destructive(Text("OK"), action: {
                        viewModel.deleteItem()
                        dismiss()
                    }))
        }
         
    }
    
    init(picture: PictureInfo, onDismissDetailView: @escaping (UUID, String, Bool) -> Void) {
        _viewModel = StateObject(wrappedValue: DetailScreenModel(picture: picture, onDismissDetailView: onDismissDetailView))
    }   
}

struct DetailScreen_Previews: PreviewProvider {
    
    @State static var previewPicture = PictureInfo(id: UUID(), PicName: "Test", locations: [MKPointAnnotationCodable.exampleForAddPhoto], PicData: Data())
    
    
    static var previews: some View {
        DetailScreen(picture: previewPicture) { _,_,_  in } // - this is our empty parameteres of closure
    }

}
