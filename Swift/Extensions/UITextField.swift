//
//  UITextField.swift
//
//  Created by Adil Umer on 12.11.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

extension UITextField{
    
    func setPlaceholderWithTypeAnimation(typedText: String, characterDelay: TimeInterval = 5.0) {
        placeholder = ""
        var writingTask: DispatchWorkItem?
        writingTask = DispatchWorkItem {
            for character in typedText {
                DispatchQueue.main.async {
                    if self.placeholder == nil {
                        self.placeholder = String(character)
                    }else{
                        self.placeholder?.append(character)
                    }
                }
                Thread.sleep(forTimeInterval: characterDelay/100)
            }
        }
        
        if let task = writingTask {
            let queue = DispatchQueue(label: "typespeed", qos: DispatchQoS.userInteractive)
            queue.asyncAfter(deadline: .now() + 0.05, execute: task)
        }
    }
}
