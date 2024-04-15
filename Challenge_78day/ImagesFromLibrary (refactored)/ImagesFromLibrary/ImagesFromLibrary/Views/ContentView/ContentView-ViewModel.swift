//
//  ContentView-ViewModel.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 07.04.2024.
//

import Foundation
import UIKit
import MapKit


@MainActor class ContentViewModel: ObservableObject {
    

    @Published var showingAddPhoto = false
    
    @Published var image:UIImage?
    
    @Published var pictures: [PictureInfo] = []
    
    @Published var hasInitialized = false
    
    
    func Initialization() {
        hasInitialized = true
        pictures = DataManaging.loadPictureInfo(pathName: DataManaging.AccessKey.keyForPictures.rawValue)
    }
    
    
    
    func CheckingDSUpdates(uuid:UUID, newName: String, statusForDelete:Bool) {
        if statusForDelete == false {
            if let index = pictures.firstIndex(where: { $0.id == uuid }) {
                if pictures[index].PicName != newName {
                    pictures[index].PicName = newName
                    DataManaging.savePictureInfo(pathName: DataManaging.AccessKey.keyForPictures.rawValue, pictures: pictures)
                }
            }
        } else {
            if let index = pictures.firstIndex(where: { $0.id == uuid }) {
                pictures.remove(at: index)
                DataManaging.savePictureInfo(pathName: DataManaging.AccessKey.keyForPictures.rawValue, pictures: pictures)
            }
        }
    }
}
