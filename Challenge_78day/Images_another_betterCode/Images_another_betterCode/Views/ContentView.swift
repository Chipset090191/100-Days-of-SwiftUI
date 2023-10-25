//
//  ContentView.swift
//  Images_another_betterCode
//
//  Created by Михаил Тихомиров on 20.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage:UIImage?
    @State private var showingEditingPictureView = false
    @State private var pictures = [Picture]()
    
    
    var body: some View {
        NavigationView{
            List {
                ForEach(pictures) { picture in
                    NavigationLink(destination: DetailView(picture: picture)) {
                        Text (picture.pictureName)
                    }
                }
                .onDelete(perform: removeItems(at:))
            }
            .navigationTitle("Photo Album")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        self.showingEditingPictureView = true
                    }label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
            .sheet(isPresented: $showingEditingPictureView) {
                EditPictureView(pictures: self.$pictures)
            }
            .onAppear{
                self.pictures = MenageData.loadPictures(pathName: "Pictures")
            }
        }
    }
    
    func removeItems(at ofsetts: IndexSet) {
        let image = pictures[ofsetts.first!]
        
        MenageData.removeImage(pathName: image.id.uuidString)
        pictures.remove(atOffsets: ofsetts)
        
        MenageData.savedPictures(pathName: "Pictures", pictures: self.pictures)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
