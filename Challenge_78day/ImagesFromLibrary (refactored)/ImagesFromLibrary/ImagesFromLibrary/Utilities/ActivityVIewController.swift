//
//  ActivityVIewController.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 13.04.2024.
//

import SwiftUI

struct ActivityVIewController: UIViewControllerRepresentable {
   
    
    typealias UIViewControllerType = UIActivityViewController
    
    let activityItems: [Any]
    
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // no need that peace
    }
}

//#Preview {
//    ActivityVIewController()
//}
