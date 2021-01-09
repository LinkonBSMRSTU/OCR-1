//
//  ViewController.swift
//  OCR-1
//
//  Created by Fazle Rabbi Linkon on 9/1/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var galleryButton: UIBarButtonItem!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.stopAnimating()
    }

    private func startAnimating() {
        self.loadingActivity.startAnimating()
    }

    private func stopAnimating() {
        self.loadingActivity.stopAnimating()
    }

    @IBAction func galleryButtonTapped(_ sender: Any) {
        setupGallery()
    }

    private func setupGallery() {

        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)) {

            let photoLibraryPicker = UIImagePickerController()
            photoLibraryPicker.delegate = self
            photoLibraryPicker.allowsEditing = true
            photoLibraryPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(photoLibraryPicker, animated: true, completion: nil)

        }

    }


}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.galleryImageView.image = image
    }

}

