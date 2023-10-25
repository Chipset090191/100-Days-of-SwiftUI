//
//  ContentView_ViewModel.swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 14.08.2023.
//

import Foundation
import UIKit
import SwiftUI

extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var image: Image?
        @Published var name = ""
        @Published var imagedata:Data?
        
        @Published private(set) var imagesInfo:[Images]
        
        @Published var presentationOfImage = [Unrapped_Info]()
    
        
        
        @Published var inputImage:UIImage?
        @Published var showingImagePicker = false
        @Published var showingPreviewDialog = false
        
        
        
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedInfo")
        
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                let items = try JSONDecoder().decode([Images].self, from: data)
                
                imagesInfo = items.sorted()
                
                formingUIImageArray()
            } catch {
                imagesInfo = []
            }
        }
            
//            do {
//                let data2 = try Data(contentsOf: savePath2)
//
//            }
        
        
        
        
        func pickedImage() {
            
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
            
        
            if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
                imagedata = jpegData
            }
        
        }
        
        func addition(elementOnSave: Images, elementOnAppear: Unrapped_Info) {
            imagesInfo.append(elementOnSave)                  // added in array for saving in documents directory
            presentationOfImage.append(elementOnAppear)       // added in array for presentation
            save()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(imagesInfo)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print ("could not save data")
            }
            
        }
        
        
        func update(current_element: Unrapped_Info,elementOnSave: Images, elementOnAppear: Unrapped_Info) {
            

           
            if let index = presentationOfImage.firstIndex(of: current_element){
                presentationOfImage[index] = elementOnAppear
            }

            if let index = imagesInfo.firstIndex(where: {$0.filename == current_element.filename}) {
                imagesInfo[index].filename = elementOnSave.filename
            }
            

            save()
        }
        
        
        func formingUIImageArray () {
            for index in 0..<imagesInfo.count {
                if let uiimage = UIImage(data: imagesInfo[index].imagedata) {
                    let new_image = Image(uiImage: uiimage)
                    presentationOfImage.append(Unrapped_Info(id: imagesInfo[index].id, filename: imagesInfo[index].filename, image: new_image, imagedata: imagesInfo[index].imagedata))
                }
            }
            
        }
        
        
        
        
        
    }
    
}
