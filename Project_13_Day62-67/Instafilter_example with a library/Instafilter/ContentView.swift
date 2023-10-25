//
//  ContentView.swift
//  Instafilter
//
//  Created by Михаил Тихомиров on 17.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var image:Image?                 // that`s a swiftUI image
    @State private var inputImage:UIImage?          // that`s a UIImage
    @State private var showingImagePicker = false
    
    
    
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Button("Select Image") {
                showingImagePicker = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }
                
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)                   // this is our UIViewController that`s wrapped to swiftUI
        }
        .onChange(of: inputImage) { _ in loadImage() }        // here we look at some changes and when that is we just proceed our func and load our Image
    }
    
    // this func to monitor the state of InputImage and if there is an Image it loads that to "image"
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
