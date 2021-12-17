//
//  gallery.swift
//
//  Created by Adil Umer on 2.11.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

let uimage = UIImage(named: "whiteIco")

struct Gallery{
    
    static func nonet(width: CGFloat)->[UIView]{
        var gallery: [UIView] = hexet(width: width)
        let marginY = width*0.995
        
        let margin = width*0.05
        let stdWidth = width*0.58
        let secWidth = (stdWidth - margin)/2
        let secMarginX = secWidth+2*margin
        let secMarginY = secWidth+margin
        
        let singletonA: UIButton = UIButton(frame: CGRect(x: secMarginX, y: marginY, width: stdWidth, height: stdWidth))
        let singletonB: UIButton = UIButton(frame: CGRect(x: margin, y: marginY, width: secWidth, height: secWidth))
        let singletonC: UIButton = UIButton(frame: CGRect(x: margin, y: marginY+secMarginY, width: secWidth, height: secWidth))

        singletonA.setImage(uimage, for: .normal)
        singletonB.setImage(uimage, for: .normal)
        singletonC.setImage(uimage, for: .normal)
        singletonA.tag = 7
        singletonB.tag = 8
        singletonC.tag = 9
        
        gallery.append(singletonA)
        gallery.append(singletonB)
        gallery.append(singletonC)
        
        return gallery
        
    }
    
    static func octet(width: CGFloat)->[UIView]{
        var gallery: [UIView] = duet(width: width)
        let marginY = width*0.995
        gallery[0].frame.origin.y = marginY
        gallery[1].frame.origin.y = marginY
        gallery[0].tag = 7
        gallery[1].tag = 8
        gallery += hexet(width: width)
        return gallery
        
    }
    
    static func heptet(width: CGFloat)->[UIView]{
        var gallery: [UIView] = duet(width: width)
        let marginY = width*1.155
        gallery[0].frame.origin.y = marginY
        gallery[1].frame.origin.y = marginY
        gallery[0].tag = 6
        gallery[1].tag = 7
        gallery += pentet(width: width)
        return gallery
        
    }
    
    static func hexet(width: CGFloat)->[UIView]{
        var gallery: [UIView] = triplet(width: width)
        let margin = width*0.05
        let majorMarginY = width*0.68
        let stdWidth = width*0.53/2
        
        let singletonA: UIButton = UIButton(frame: CGRect(x: margin, y: majorMarginY, width: stdWidth, height: stdWidth))
        let singletonB: UIButton = UIButton(frame: CGRect(x: width*0.73/2, y: majorMarginY, width: stdWidth, height: stdWidth))
        let singletonC: UIButton = UIButton(frame: CGRect(x: width*1.36/2, y: majorMarginY, width: stdWidth, height: stdWidth))

        singletonA.setImage(uimage, for: .normal)
        singletonB.setImage(uimage, for: .normal)
        singletonC.setImage(uimage, for: .normal)
        singletonA.tag = 4
        singletonB.tag = 5
        singletonC.tag = 6
        
        gallery.append(singletonA)
        gallery.append(singletonB)
        gallery.append(singletonC)
        return gallery
        
    }
    
    static func pentet(width: CGFloat)->[UIView]{
        var gallery: [UIView] = duet(width: width)
        gallery[0].tag = 4
        gallery[1].tag = 5
        let marginY = width*0.68
        gallery[0].frame.origin.y = marginY
        gallery[1].frame.origin.y = marginY
        gallery += triplet(width: width)
        return gallery
        
    }
    
    static func quadret(width: CGFloat)->[UIView]{
        var gallery: [UIView] = duet(width: width)
        gallery[0].tag = 3
        gallery[1].tag = 4
        let marginY = width*0.525
        gallery[0].frame.origin.y = marginY
        gallery[1].frame.origin.y = marginY
        gallery += duet(width: width)
        return gallery
    }
    
    static func triplet(width: CGFloat)->[UIView]{
        var gallery: [UIView] = []
        let margin = width*0.05
        let stdWidth = width*0.58
        let secWidth = (stdWidth - margin)/2
        let secMarginX = stdWidth+2*margin
        let secMarginY = secWidth+2*margin
        
        let singletonA: UIButton = UIButton(frame: CGRect(x: margin, y: margin, width: stdWidth, height: stdWidth))
        let singletonB: UIButton = UIButton(frame: CGRect(x: secMarginX, y: margin, width: secWidth, height: secWidth))
        let singletonC: UIButton = UIButton(frame: CGRect(x: secMarginX, y: secMarginY, width: secWidth, height: secWidth))

        singletonA.setImage(uimage, for: .normal)
        singletonB.setImage(uimage, for: .normal)
        singletonC.setImage(uimage, for: .normal)
        
        singletonA.tag = 1
        singletonB.tag = 2
        singletonC.tag = 3
        
        gallery.append(singletonA)
        gallery.append(singletonB)
        gallery.append(singletonC)
        return gallery
        
    }
    
    static func duet(width:CGFloat)->[UIView]{
        var gallery: [UIView] = []
        let margin = width*0.05
        let stdWidth = width*0.425
        
        let singletonA: UIButton = UIButton(frame: CGRect(x: margin, y: margin, width: stdWidth, height: stdWidth))
        let singletonB: UIButton = UIButton(frame: CGRect(x: stdWidth+2*margin, y: margin, width: stdWidth, height: stdWidth))

        singletonA.setImage(uimage, for: .normal)
        singletonA.tag = 1
        singletonB.setImage(uimage, for: .normal)
        singletonB.tag = 2
        
        gallery.append(singletonA)
        gallery.append(singletonB)
        return gallery
    }
    
    static func singlet(width:CGFloat)->[UIView]{
        var gallery: [UIView] = []
        let margin = width*0.05
        let stdWidth = width*0.9
        
        let singleton: UIButton = UIButton(frame: CGRect(x: margin, y: margin, width: stdWidth, height: stdWidth))
        
        singleton.tag = 1
        singleton.setImage(uimage, for: .normal)
        
        gallery.append(singleton)
        return gallery
    }
    
    static func getGallery(itemCount: Int, width: CGFloat)->[UIView]{
        switch itemCount {
        case 1:
            return singlet(width: width)
        case 2:
            return duet(width: width)
        case 3:
            return triplet(width: width)
        case 4:
            return quadret(width: width)
        case 5:
            return pentet(width: width)
        case 6:
            return hexet(width: width)
        case 7:
            return heptet(width: width)
        case 8:
            return octet(width: width)
        case 9:
            return nonet(width: width)
        default:
            return singlet(width: width)
        }
    }
    
}
