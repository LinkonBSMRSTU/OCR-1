//
//  MainViewController.swift
//  OCR-1
//
//  Created by Fazle Rabbi Linkon on 10/1/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var ocrView: UIButton!
    @IBOutlet weak var faceDetectorView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Select an Option"
        
        self.setRoundedView(view: ocrView)
        self.setRoundedView(view: faceDetectorView)
        
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
