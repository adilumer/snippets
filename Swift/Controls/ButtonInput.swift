//
//  ButtonInput.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import SwiftIcons

enum stdButtonType: Int, CaseIterable{
    case single, step, withIcon, onlyIcon
    
    func next() -> Self {
        var butTyp: stdButtonType = .single
        if self == stdButtonType.allCases[stdButtonType.allCases.count-1]{
            butTyp = stdButtonType.allCases[0]
        }else{
            stdButtonType.allCases.forEach { typ in
                if typ.rawValue == self.rawValue + 1{
                    butTyp = typ
                }
            }
        }
        return butTyp
    }
    
}

enum stdButtonBg{
    case primary, secondary, accept, reject, transparent, white, cancel
}

enum stdButtonFg{
    case primary, secondary, tertiary
}

class ButtonInput: UIButton {
    var fgColorType: stdButtonFg = .primary{
        didSet{
            switch fgColorType {
            case .primary:
                setTitleColor(.white, for: .normal)
                tintColor = .white
            case .secondary:
                setTitleColor(.black, for: .normal)
                tintColor = .black
            case .tertiary:
                setTitleColor(UIColor(red: CGFloat(2 / 255.0), green: CGFloat(72 / 255.0),blue: CGFloat(195 / 255.0),alpha: CGFloat(1.0)), for: .normal)
                tintColor = UIColor(red: CGFloat(2 / 255.0), green: CGFloat(72 / 255.0),blue: CGFloat(195 / 255.0),alpha: CGFloat(1.0))
            }
        }
    }
    
    var bgColorType:stdButtonBg = .primary{
        didSet {
            switch bgColorType {
            case .cancel:
                backgroundColor = UIColor(red: CGFloat(2 / 255.0), green: CGFloat(72 / 255.0),blue: CGFloat(195 / 255.0),alpha: CGFloat(1.0))
            case .primary:
                backgroundColor = UIColor(red: CGFloat(2 / 255.0), green: CGFloat(72 / 255.0),blue: CGFloat(195 / 255.0),alpha: CGFloat(1.0))
            case .reject:
                backgroundColor = UIColor(red: CGFloat(207 / 255.0), green: CGFloat(24 / 255.0),blue: CGFloat(24 / 255.0),alpha: CGFloat(1.0))
            case .secondary:
                backgroundColor = UIColor(red: CGFloat(2 / 255.0), green: CGFloat(72 / 255.0),blue: CGFloat(195 / 255.0),alpha: CGFloat(1.0))
            case .transparent:
                backgroundColor = .none
            case .white:
                backgroundColor = .white
            case .accept:
                backgroundColor = UIColor(red: CGFloat(132 / 255.0), green: CGFloat(200 / 255.0),blue: CGFloat(59 / 255.0),alpha: CGFloat(1.0))
            }
        }
    }
    
    var roundedStyle: Int = 0{
        didSet{
            if roundedStyle == 0{
                layer.cornerRadius = 0
            }else if roundedStyle == -1{
                makeRounded()
            }else if roundedStyle == -2{
                layer.cornerRadius = 5
            }else if roundedStyle == -3{
                layer.cornerRadius = 10
            }else{
                layer.cornerRadius = CGFloat(roundedStyle)
            }
        }
    }
    
    var shadow: Bool = false{
        didSet{
            if shadow {
                layer.shadowOffset = CGSize(width: 0, height: 5.0)
                layer.shadowRadius = 1
                layer.shadowColor = UIColor.gray.cgColor
                layer.shadowOpacity = 1
                layer.shouldRasterize = true
                layer.rasterizationScale = UIScreen.main.scale
            }
        }
    }
    
    var butIcon: FontType = .fontAwesomeSolid(.arrowRight) {
        didSet {
            setImage(UIImage.init(icon: butIcon, size: CGSize(width: 50, height: 20)), for: .normal)
            setImage(UIImage.init(icon: butIcon, size: CGSize(width: 50, height: 20)), for: .disabled)
        }
    }
    
    var iconBoxed: Bool = false{
        didSet{
            if iconBoxed {
                imageView?.backgroundColor = .blue
                imageView?.layer.cornerRadius = 5
            }else{
                imageView?.backgroundColor = .none
            }
        }
    }
    var boundMargins:CGFloat = 0
    var btnType: stdButtonType = .single{
        didSet {
            switch btnType {
            case .onlyIcon:
                iconButton()
            case .withIcon:
                iconTxtButton()
            case .step:
                stepButton(margins: boundMargins)
            case .single:
                singleButton()
            }
        }
    }
    
    func singleButton(){
        contentHorizontalAlignment = .center
        roundedStyle = -2
    }
    
    func stepButton(margins: CGFloat = 0){
        butIcon = .fontAwesomeSolid(.longArrowAltRight)
        contentHorizontalAlignment = .left
        contentVerticalAlignment = .center
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 45)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: bounds.width.relativeToIphone8Width(margins: margins) - 45, bottom: 0, right: 0)
        sizeToFit()
        imageView?.frame.origin.x = bounds.width.relativeToIphone8Width(margins: margins) - 45
        backgroundColor = UIColor(red: CGFloat(2 / 255.0), green: CGFloat(72 / 255.0),blue: CGFloat(195 / 255.0),alpha: CGFloat(1.0))
        roundedStyle = -2
        shadow = false
        iconBoxed = false
        fgColorType = .primary
    }
    
    func iconButton(){
        butIcon = .fontAwesomeSolid(.longArrowAltRight)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        imageView?.contentMode = .scaleAspectFill
        setTitle("", for: .normal)
        bgColorType = .accept
        roundedStyle = -2
        shadow = true
        iconBoxed = false
        fgColorType = .primary
    }
    
    func iconTxtButton(title: String = "Default Title"){
        butIcon = .fontAwesomeSolid(.longArrowAltRight)
        contentHorizontalAlignment = .left
        contentVerticalAlignment = .center
        imageView?.contentMode = .scaleAspectFill
        backgroundColor = UIColor(red: CGFloat(2 / 255.0), green: CGFloat(72 / 255.0),blue: CGFloat(195 / 255.0),alpha: CGFloat(1.0))
        setTitle(title, for: .normal)
        roundedStyle = -2
        shadow = true
        iconBoxed = false
        fgColorType = .primary
    }
    
    func stdAttributedTitle(_ txt: String){
        let wordArray = txt.byWords
        let lastWord = wordArray.last ?? " "
        let restOfSentence = txt.prefix(txt.count - lastWord.count)
        let fontA = UIFont(name: "OpenSans-Regular", size: 17.0)!
        let fontB = UIFont(name: "OpenSans-SemiBold", size: 17.0)!
        let preStr = NSAttributedString(string: String(restOfSentence), attributes: [NSAttributedString.Key.font: fontA])
        let postStr = NSAttributedString(string: String(lastWord), attributes: [NSAttributedString.Key.font: fontB])
        let combination = NSMutableAttributedString()
        combination.append(preStr)
        combination.append(postStr)
        setAttributedTitle(combination, for: .normal)
        setAttributedTitle(combination, for: .disabled)
    }
    
    func secondaryAttributedTitle(_ first: String, _ second: String){
        titleLabel?.lineBreakMode = .byWordWrapping
        let fontA = UIFont(name: "Georgia", size: 17.0)!
        let fontB = UIFont(name: "Arial", size: 17.0)!
        let preStr = NSAttributedString(string: first+"\n", attributes: [NSAttributedString.Key.font: fontA, NSAttributedString.Key.foregroundColor: UIColor.blue])
        let postStr = NSAttributedString(string: second, attributes: [NSAttributedString.Key.font: fontB, NSAttributedString.Key.foregroundColor: UIColor.green])
        let combination = NSMutableAttributedString()
        combination.append(preStr)
        combination.append(postStr)
        setAttributedTitle(combination, for: .normal)
        setAttributedTitle(combination, for: .disabled)
    }
    
    init(frame: CGRect, type: stdButtonType) {
        super.init(frame: frame)
        btnType = type
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
