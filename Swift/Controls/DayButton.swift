//
//  DayButton.swift
//
//  Created by Adil Umer on 28.11.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit

class DayButton: UIButton{
    
    var dayStr: String = ""
    var dayIndex: Int = -1
    var isActive: Bool = false{
        didSet{
            bLayer.isHidden = !isActive
            checkBox.isHidden = !isActive
        }
    }
    
    var check = UIImage(icon: .fontAwesomeSolid(.checkCircle), size: CGSize(width: 5, height: 5), textColor: .green, backgroundColor: .clear)
    var checkBox = UIImageView(frame: .zero)
    var bLayer = CALayer()
    
    func overlaySetup(){
        
        let size = self.frame.size
        bLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bLayer.borderColor = UIColor.green.cgColor
        bLayer.borderWidth = 1
        bLayer.cornerRadius = 5
        self.layer.insertSublayer(bLayer, at: 0)
        
        checkBox.frame = CGRect(x: (size.width-20)/2, y: (size.height-10), width: 20, height: 20)
        checkBox.image = check
        checkBox.clipsToBounds = false
        self.addSubview(checkBox)
    }
    
    func setDay(){
        if dayIndex > -1 && dayIndex < 7{
            self.setTitle(daysAbbr[dayIndex].localized(), for: .normal)
            dayStr = daysOfWeek[dayIndex].localized()
        }else{
            self.setTitle("*", for: .normal)
            dayStr = "*"
        }
    }
    
    func toggleActive(){
        isActive = !isActive
    }
    
    func hideOverlay(){
        bLayer.isHidden = true
        checkBox.isHidden = true
    }
    
    func showOverlay(){
        bLayer.isHidden = false
        checkBox.isHidden = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        self.setTitleColor(UIColor.darkGray, for: .normal)
        overlaySetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 14)
        self.setTitleColor(UIColor.darkGray, for: .normal)
        overlaySetup()
    }
}
