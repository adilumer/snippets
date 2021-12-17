//
//  AssetButton.swift
//
//  Created by Adil Umer on 30.11.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class AssetButton: UIButton {

    var index = -1
    var asset = AssetObj([:])
    var iFrame = CGRect.zero
    
    func loadBkd(){
        let rawStr = "\(apiUrl)/asset/\(userUUID!)/thumb-\(asset.url)"
        let urlStr = asset.ext == "mp4" ? "\(rawStr).png" : rawStr
        let imgUrl = URL(string: urlStr)!
        self.loadImg(withUrl: imgUrl)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        //self.layer.borderWidth = 5
        //self.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    init(index: Int){
        let stdSide = (screenWidth()-72)/4
        var x = CGFloat(index) * stdSide
        var y:CGFloat = 0
        if index > 4 {
            x = CGFloat(index-4) * stdSide
            y = stdSide
        }
        if index > 8 {
            x = CGFloat(index-8) * stdSide
            y = stdSide*2
        }
        iFrame = CGRect(x: x, y: y, width: stdSide, height: stdSide)
        super.init(frame: iFrame)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        self.setTitleColor(UIColor.darkGray, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        self.setTitleColor(UIColor.darkGray, for: .normal)
    }

}
