//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Михаил Тихомиров on 21.07.2023.
//

import UIKit

// UIImageWriteToSavedPhotosAlbum - params:
// 1 - UIImage
// 2 - the target (who to tell when it`s finished)
// 3 - Selector ()


class ImageSaver:NSObject {
    func writeToPhotoAlbum(image:UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    
    // so that`s a completion function
    @objc func saveCompleted(_ image:UIImage, didFinishSavingWithError error:Error?, contextInfo:UnsafeRawPointer) {
        print("Save finished!")
    }
}
