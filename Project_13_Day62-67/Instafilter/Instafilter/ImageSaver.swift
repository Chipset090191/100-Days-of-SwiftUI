import UIKit

// UIImageWriteToSavedPhotosAlbum - params:
// 1 - UIImage
// 2 - the target (who to tell when it`s finished)
// 3 - Selector ()


class ImageSaver:NSObject {
    var successHandler: (() -> Void)?               // that`s for error if it will be
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image:UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    
    // so that`s a completion function
    
    @objc func saveCompleted(_ image:UIImage, didFinishSavingWithError error:Error?, contextInfo:UnsafeRawPointer) {
//        print("Save finished!")
        if let error = error {
            errorHandler?(error)    // if we have error then call our errorHandler
        } else {
            successHandler?()  // if there is no error
        }
    }
}
