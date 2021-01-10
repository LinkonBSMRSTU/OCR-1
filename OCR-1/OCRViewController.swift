//
//  ViewController.swift
//  OCR-1
//
//  Created by Fazle Rabbi Linkon on 9/1/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit
import Vision
import VisionKit

class OCRViewController: UIViewController {

    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!

    
    var cameraTapped: Bool = false
    
    var visionRequest = VNRecognizeTextRequest(completionHandler: nil)
    let imageSaver = ImageSaver()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Document to Text"
        
        self.stopAnimating()
        self.startAction(cameraTapped: self.cameraTapped)
    }
    
    //----------------------------------------------
    // MARK: Activity Indication Animation Function
    //----------------------------------------------
    private func startAnimating() {
        self.loadingActivity.startAnimating()
    }

    private func stopAnimating() {
        self.loadingActivity.stopAnimating()
    }
    
    private func startAction(cameraTapped: Bool) {
        if (cameraTapped) {
            self.configureCameraToDocView()
        }
        else {
            self.setupGallery()
        }
    }

    
    
    
    
    //--------------------------------------------------
    // MARK: Camera Image To Text Recognition Functions
    //--------------------------------------------------
    private func configureCameraToDocView(){
        let scanningDocVc = VNDocumentCameraViewController()
        scanningDocVc.delegate = self
        self.present(scanningDocVc, animated: true, completion: nil)
    }
    
    
    
    
    
    //--------------------------------------------------
    // MARK: Gallery Image To Text Recognition Functions
    //--------------------------------------------------
    private func setupGallery() {

        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)) {

            let photoLibraryPicker = UIImagePickerController()
            photoLibraryPicker.delegate = self
            photoLibraryPicker.allowsEditing = true
            photoLibraryPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(photoLibraryPicker, animated: true, completion: nil)
        }
    }

    private func setupVisionTextRecognize(image: UIImage?) {

        var textString = ""

        visionRequest = VNRecognizeTextRequest(completionHandler: { (request, error) in

            guard let observations = request.results as? [VNRecognizedTextObservation]
                else {
                    let errorTitle = "Observation Error"
                    let errorMessage = "Received Invalid Observation"
                    self.showAlert(title: errorTitle, message: errorMessage)
                    fatalError(errorMessage)
            }
            
            for observation in observations {
                
                guard let topCandidate = observation.topCandidates(1).first
                    else {
                        print("No Candidate Found")
                        continue
                }
                
                textString += "\n\(topCandidate.string)"
                
                DispatchQueue.main.async {
                    self.stopAnimating()
                    self.resultTextView.text = textString
                }
            }
        })
        
        //Detection Properties
        visionRequest.customWords = ["custom"]
        visionRequest.minimumTextHeight = 0.03125
        visionRequest.recognitionLevel = .accurate
        visionRequest.recognitionLanguages = ["en_US"]
        visionRequest.usesLanguageCorrection = true
        
        let requests = [visionRequest]
        
        //Create Request Handler
        DispatchQueue.global(qos: .userInitiated).async {
            
            guard let img = image?.cgImage
                else {
                    let errorTitle = "Missing Image"
                    let errorMessage = "Missing Image to Scan"
                    self.showAlert(title: errorTitle, message: errorMessage)
                    fatalError(errorMessage)
            }
            
            let handler = VNImageRequestHandler(cgImage: img, options: [:])
            try? handler.perform(requests)
        }
        
    }

}



//--------------------------------------------------
// MARK: Alert Controller Functions
//--------------------------------------------------
extension OCRViewController {
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
           self.dismissAlert()
       }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
}


//----------------------------------------------------------------
// MARK: Camera Image to Text Recongnition Completition Functions
//----------------------------------------------------------------
extension OCRViewController: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        
        for pageNumber in 0..<scan.pageCount {
            
            let image = scan.imageOfPage(at: pageNumber)
            self.startAnimating()
            self.resultTextView.text = ""
            self.galleryImageView.image = image
            self.setupVisionTextRecognize(image: image)
            
            imageSaver.writeToPhotoAlbum(image: image)
            
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        print(error)
        self.showAlert(title: "Error", message: error.localizedDescription)
        controller.dismiss(animated: true)
    }
    
}


//----------------------------------------------------------------
// MARK: Gallery Image to Text Recongnition Completition Functions
//----------------------------------------------------------------
extension OCRViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        picker.dismiss(animated: true, completion: nil)
        
        self.startAnimating()
        self.resultTextView.text = ""

        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.galleryImageView.image = image
        
        self.setupVisionTextRecognize(image: image)
    }
}

