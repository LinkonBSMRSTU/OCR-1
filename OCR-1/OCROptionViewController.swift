//
//  OCROptionViewController.swift
//  OCR-1
//
//  Created by Fazle Rabbi Linkon on 10/1/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class OCROptionViewController: UIViewController {

    let ocrVC = OCRViewController()
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var galleryView: UIView!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var galleryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Choose from Photos or Camera"
        
        self.setRoundedView(view: cameraView)
        self.setRoundedView(view: galleryView)
        self.setLabelColor()
    }
    

    private func setLabelColor() {
        self.cameraLabel.textColor = UIColor.systemBlue
        self.galleryLabel.textColor = UIColor.systemBlue
        
        self.cameraLabel.layer.shadowColor = UIColor.green.cgColor
        self.cameraLabel.layer.shadowRadius = 2.0
        self.cameraLabel.layer.shadowOpacity = 0.5
        self.cameraLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.cameraLabel.layer.masksToBounds = false
        
        self.galleryLabel.layer.shadowColor = UIColor.green.cgColor
        self.galleryLabel.layer.shadowRadius = 2.0
        self.galleryLabel.layer.shadowOpacity = 0.5
        self.galleryLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.galleryLabel.layer.masksToBounds = false
    }
    
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OCRViewController") as? OCRViewController
        vc?.cameraTapped = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func galleryButtonTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OCRViewController") as? OCRViewController
        vc?.cameraTapped = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    private func setRoundedView(view: UIView) {
        // corner radius
        view.layer.cornerRadius = 10

        // border
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor

        // shadow
        view.layer.shadowColor = UIColor.green.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.0
    }
}
