//
//  DetailScreen-ViewModel.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 10.04.2024.
//

import Foundation
import CoreLocation
import SwiftUI


@MainActor class DetailScreenModel: ObservableObject {
    
    
    
    @Published var picture:PictureInfo
    
    @Published var centerCoordinatePub: CLLocationCoordinate2D?
    
    @Published var currentZoom = 0.0
    
    @Published var totalZoom = 1.0
    
    @Published var onDismissDetailView: (UUID, String, Bool)->Void
    
    @Published var showingAlertForDelete = false
    
    @Published var showingActivityViewController = false
    
    
    
    var centerCoordinate = CLLocationCoordinate2D()
    
    
    init(picture: PictureInfo, onDismissDetailView: @escaping (UUID, String, Bool) -> Void) {
        self.picture = picture
        self.onDismissDetailView = onDismissDetailView
    }
    
    func deleteItem() {
        picture.statusForDelete = true
    }
    
    func onChangeZoom(value: CGFloat) {
        if value - 1 <= -0.5 {
            currentZoom = -0.5
        } else {
            currentZoom = value - 1
            
        }
    }
    
    func onEndedZoom() {
        totalZoom += currentZoom
        currentZoom = 0
        if totalZoom <= 0.5 {
            totalZoom = 0.5
        }
    }
}
