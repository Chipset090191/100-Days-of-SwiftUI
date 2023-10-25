//
//  ImagePicker.swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 13.08.2023.
//
import PhotosUI
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    
    
    @Binding var image:UIImage?
    
    
    
    
    class Coordinator:NSObject,PHPickerViewControllerDelegate {
        
        var parent:ImagePicker
        
        
        init(parent:ImagePicker) {
            self.parent = parent
        }
        
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true) {
                guard let provider = results.first?.itemProvider else { return }
                
                if provider.canLoadObject(ofClass: UIImage.self) {
                    provider.loadObject(ofClass: UIImage.self) { image, _ in
                        Task { @MainActor in
                            self.parent.image = image as? UIImage
                            
                        
                            
                        }
                    }
                    
                }
                
                
                
            }
        }
        
        
        
    }
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
}



//struct ImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePicker()
//    }
//}
