//
//  LoadingView.swift
//
//  Created by Adil Umer on 15.12.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingView: UIViewController {

    //@IBOutlet weak var imageHolder: UIImageView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var logoFill: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.color = ProjectDefaults.DarkerPrimary
        indicator.type = .ballPulse
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indicator.startAnimating()
    }
    override func viewDidAppear(_ animated: Bool) {
        //animate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        indicator.stopAnimating()
        //imageHolder.stopAnimating()
    }

    func setupView(){
        
    }
    /*
    func animate(){
        var images:[UIImage] = []
        for i in 0...59 {
            let  fileStr = String(format: "CP%02d", i)
            images.append(UIImage(named: fileStr)!)
        }
        
        imageHolder.transform = .init(scaleX: 1.1, y: 1.1)
        imageHolder.animationImages = images
        imageHolder.animationDuration = 1.5
        imageHolder.startAnimating()
    }
     */

}
