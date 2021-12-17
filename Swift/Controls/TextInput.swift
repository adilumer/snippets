//
//  TextInput.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import SwiftIcons

class TextInput: UITextField {

    var pastable = true
    var sublayer: UIView!
    var inputLabel: UILabel!
    var inputTxt: UITextField!
    var inputImg: UIImageView!
    
    var placeholderTxt: String = ""{
        didSet{
            inputLabel.text = "  \(placeholderTxt)  "
            inputTxt.placeholder = "  \(placeholderTxt)  "
            inputLabel.sizeToFit()
        }
    }
    
    var roundedStyle: Int = 0{
        didSet{
            if roundedStyle == 0{
                layer.cornerRadius = 0
            }else if roundedStyle == -1{
                layer.cornerRadius = 5
            }else if roundedStyle == -2{
                layer.cornerRadius = 10
            }else{
                layer.cornerRadius = CGFloat(roundedStyle)
            }
            sublayer.layer.cornerRadius = layer.cornerRadius
        }
    }
    
    var borders: CGFloat = 0{
        didSet{
            sublayer.layer.borderWidth = borders
            sublayer.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    var inputIcon: FontType = .fontAwesomeSolid(.arrowRight) {
        didSet {
            inputImg.image = UIImage.init(icon: inputIcon, size: CGSize(width: 40, height: 40))
            inputImg.contentMode = .scaleAspectFit
        }
    }
    
    init(frame: CGRect, icon: FontType, fieldName: String) {
        super.init(frame: frame)
        inputIcon = icon
        placeholderTxt = fieldName
        addViews()
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
    }
    
    func addViews(){
        /*for view in subviews{
            view.removeFromSuperview()
        }*/
        sublayer = UIView(frame: CGRect(x: 2, y: 2, width: layer.frame.width-2, height: layer.frame.height-2))
        inputLabel = UILabel(frame: CGRect(x: 12, y: -6, width: layer.frame.width/3, height: 24))
        inputTxt = UITextField(frame: CGRect(x: 18, y: 12, width: layer.frame.width - 50, height: layer.frame.height - 18))
        inputImg = UIImageView(frame: CGRect(x: layer.frame.width - 45, y: 18, width: 40, height: layer.frame.height - 36))
        /*addSubview(sublayer)
        addSubview(inputTxt)
        addSubview(inputLabel)
        addSubview(inputImg)*/
    }
    
    func updatePlaceHolder(){
        inputLabel.isHidden = inputTxt.text == ""
    }
    
    func setupViews(){
        borders = 2
        roundedStyle = -1
        inputLabel.text = placeholderTxt
        inputTxt.borderStyle = .none
        inputTxt.placeholder = placeholderTxt
        inputIcon = .fontAwesomeSolid(.user)
        inputLabel.backgroundColor = superview?.backgroundColor
        updatePlaceHolder()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return self.pastable
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}
