//
//  MapView.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 08.04.2024.
//  I got this piace of code from https://github.com/PetroOnishchuk/100-Days-Of-SwiftUI (Petro Onishchuk) and modify it to achive my goals! Tnhx to him!

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    
    
    var annotations: [MKPointAnnotation]
    
    var fetchedLocation: CLLocationCoordinate2D?
    
    
    // when it first appears coordinator calls this one
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        if annotations.count == 0 {
//            mapView.setCenter( CLLocationCoordinate2D(latitude: 45.039268, longitude: 38.987221), animated: true)
            mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.039268, longitude: 38.987221), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)), animated: true)
        } else {
            let location = annotations.first!.coordinate
//            mapView.setCenter(location, animated: true)
            mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)), animated: true)
        }
        return mapView
    }
    
    // when we scrolling our map our staying on it is working
    func updateUIView(_ view: MKMapView, context: Context) {
        print("Updating")

        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            // it`s updating consistantly while we scrolling our map
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // this is our unique identifier for view reuse
            let identifier = "Placemark"
            
            // attempt to find a cell we can recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                // we didn't find one; make a new one
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
               // allow this to show pop up information
                annotationView?.canShowCallout = true
                
                
               
            } else {
                // we have a view to reuse or a recycle one,  send it back
            }
                return annotationView
            
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
        
        }
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Krasnodar"
        annotation.subtitle = "Place where I was born"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 45.039, longitude: 38.987221)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider  {
    static var previews: some View {
        MapView(centerCoordinate:   .constant(MKPointAnnotation.example.coordinate),  annotations: [MKPointAnnotation.example] )
    }
}
