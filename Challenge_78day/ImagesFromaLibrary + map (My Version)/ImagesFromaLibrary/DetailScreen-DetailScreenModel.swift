//
//  DetailScreen-DetailScreenModel.swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 17.08.2023.
//

import Foundation
import UIKit
import SwiftUI
import MapKit


extension DetailScreen {

    @MainActor class DetailScreenModel: ObservableObject {

        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))

        @Published var MapAnnotationArray = [Images]()



        init() {
                    

        }
        
        
        func loadAnnotations() {
            
        }



    }

}
