//
//  ContentView.swift
//  Instafilter
//
//  Created by Михаил Тихомиров on 22.07.2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 20.0
    
    
    @State private var showingImagePicker = false
    @State private var inputImage:UIImage?
    
    @State private var processedImage:UIImage?
    
    
    // that`s options for the filter +
    // @State private var currentFilter = CIFilter.sepiaTone() // the previous mark definition
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()   // so we`ve got sepiaTone() by default and say current filter it`s not only sepiaTone() filter but a whole bunch of other filters. So as we cannot use currentFilter.intensity anymore!!. Instead, we have to define currentFilter.inputkeys and code through them!
    
    
    let context = CIContext()
    // +
    
    
    // confirmation Dialog
    @State private var showingFilterSheet = false
    
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text ("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing() }
                    
                    
                }
                .padding(.vertical)
                
                HStack {
                    Text("Radius")
                    Slider(value: $filterRadius, in: 0...1000)
                        .onChange(of: filterRadius) { _ in applyProcessing() }
                }
                .padding(.vertical)
                
                HStack {
                    Button ("Change Filter"){
                        // change filter
                        showingFilterSheet = true
                            
                    }
                    .disabled(inputImage == nil ? true : false)
                    Spacer()
                    
                    Button("Save", action:save)
// MARK: challenge 1
                        .disabled(inputImage == nil ? true : false)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter ", isPresented: $showingFilterSheet) {
                // dialog here
                Group{
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                }
                Group{
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                    Button("Bloom") { setFilter(CIFilter.bloom()) }
                    Button("Bump Distortion") { setFilter(CIFilter.bumpDistortion()) }
                    Button("Color Inversion") { setFilter(CIFilter.colorInvert()) }
                    Button("Cancel", role: .cancel) { }
                }
                
                
            }
        }
    }
    
    func loadImage() {
        
        
        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
        let beginImage = CIImage(image: inputImage)                     // we add our inputImage to CI component to produce image with filters
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)    // we set to the filter that we`ve chosen our CIImage, kCIInputImageKey - filter understands that +
        applyProcessing()                                               // + beginImage is our image for processing
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {  // that`s a closure function look at ImageSaver!
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print ("Oups! \($0.localizedDescription)")
        }
        
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
        
    }
    
    func applyProcessing() {
        //currentFilter.intensity = Float(filterIntensity)
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)   // key for intensity
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: (inputImage?.size.width)! / 2.0, y: (inputImage?.size.height)! / 2.0), forKey: kCIInputCenterKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)   // for Radius we time by 200 the value to make radius bigger
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)   // for scale multiply just by 10
        }
        
        
        
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        // if we`ve got our image with applied filter we just convert it to "image"
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
