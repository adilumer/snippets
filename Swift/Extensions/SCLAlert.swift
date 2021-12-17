//
//  SCLAlert.swift
//
//  Created by Adil Umer on 27.11.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit

extension SCLAlertView: UIPickerViewDataSource, UIPickerViewDelegate{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerviewData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerviewData[row]
    }
    
    
}
