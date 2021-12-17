//
//  CGFloat.swift
//
//  Created by Adil Umer on 2.11.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit

let minScalableValue: CGFloat = 8.0 // Min value that should undergo upper scaling for bigger iphones and iPads
extension CGFloat {
    
    // 02.12.2020 - Adil
    // Later Changed Relative to iPhone 8 Plus Viewport! For iPhone 8, use 375w x 667h.
    // Adding margins ...
    
    func relativeToIphone8Width(shouldUseLimit: Bool = true, margins:CGFloat = 0) -> CGFloat {
        let refWidth:CGFloat = 414 - margins
        let screenRelW: CGFloat = UIScreen.main.bounds.width - margins
        let upperScaleLimit: CGFloat = 1.8
        var toUpdateValue = floor(self * (screenRelW / refWidth))
        guard self > minScalableValue else {return toUpdateValue}
        guard shouldUseLimit else {return toUpdateValue}
        guard upperScaleLimit > 1 else {return toUpdateValue}
        let limitedValue = self * upperScaleLimit
        if toUpdateValue > limitedValue {
            toUpdateValue = limitedValue
        }
        return toUpdateValue
    }
    
    func relativeToIphone8Height(shouldUseLimit: Bool = true) -> CGFloat {
        var extraHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            extraHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            extraHeight = extraHeight + (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 20) - 20
        }
        let upperScaleLimit: CGFloat = 1.8
        var toUpdateValue = floor(self * ((UIScreen.main.bounds.height - extraHeight) / 736))
        guard self > minScalableValue else {return toUpdateValue}
        guard shouldUseLimit else {return toUpdateValue}
        guard upperScaleLimit > 1 else {return toUpdateValue}
        let limitedValue = self * upperScaleLimit
        if toUpdateValue > limitedValue {
            toUpdateValue = limitedValue
        }
        return toUpdateValue
    }
    
}

/* ******************** ViewPorts **********************************
*   iPhone SE                          375w x 667h                 *
*   iPhone 11 Pro Max                  414w x 896h                 *
*   iPhone 11 Xs Max                   414w x 896h                 *
*   iPhone 11                          414w x 896h                 *
*   iPhone 11 Xr                       414w x 896h                 *
*   iPhone 11 Pro                      375w x 812h                 *
*   iPhone 11 X                        375w x 812h                 *
*   iPhone 11 Xs                       375w x 812h                 *
*   iPhone X                           375w x 812h                 *
*   iPhone 8 Plus                      414w x 736h                 *
*   iPhone 8                           375w x 667h                 *
*   iPhone 7 Plus                      414w x 736h                 *
*   iPhone 7                           375w x 667h                 *
*   iPhone 6s Plus                     414w x 736h                 *
*   iPhone 6s                          375w x 667h                 *
*   iPhone 6 Plus                      414w x 736h                 *
*   iPhone 6                           375w x 667h                 *
*   iPad Pro                           1024w x 1366h               *
*   iPad Third & Fourth Generation     768w x 1024h                *
*   iPad Air 1 & 2                     768w x 1024h                *
*   iPad Mini                          768w x 1024h                *
*   iPad Mini 2 & 3                    768w x 1024h                *
*******************************************************************/
