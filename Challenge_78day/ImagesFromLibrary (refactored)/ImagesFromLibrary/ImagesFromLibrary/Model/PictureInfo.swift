//
//  PictureInfo.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 07.04.2024.
//

import Foundation
import UIKit
import SwiftUI



struct PictureInfo: Identifiable, Codable {
    
    let id: UUID
    var PicName:String
    let locations: [MKPointAnnotationCodable]
    let PicData: Data
    
    var statusForDelete: Bool = false
    
    
    
    
    // this func gets our Image when we need that
    func image() -> Image? {
        if let uiimage = UIImage(data: self.PicData) {
            return Image(uiImage: uiimage)
        }
        return nil
    }
    
    // this func gets our UIImage. For example for activityViewController
    func UIimage() -> UIImage? {
        if let uiimage = UIImage(data: self.PicData) {
            return uiimage
        }
        return nil
    }
}
