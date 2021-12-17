//
//  String.swift
//
//  Created by Adil Umer on 9.09.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation

extension String {
    
    // "some string".localized()
    // Localization Function
    func localized() -> String {
        if let _ = UserDefaults.standard.string(forKey: "i18n_language") {} else {
            // we set a default, just in case
            UserDefaults.standard.set(defaultLocale, forKey: "i18n_language")
            UserDefaults.standard.synchronize()
        }
        let lang = UserDefaults.standard.string(forKey: "i18n_language")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)!
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: "**\(self)**", comment: "")
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    var bool: Bool? {
            switch self.lowercased() {
            case "true", "t", "yes", "y":
                return true
            case "false", "f", "no", "n", "":
                return false
            default:
                if let int = Int(self) {
                    return int != 0
                }
                return nil
            }
        }
    
}

