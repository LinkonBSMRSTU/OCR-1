//
//  ImageSaver.swift
//  OCR-1
//
//  Created by Fazle Rabbi Linkon on 9/1/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import Foundation
import UIKit


class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
