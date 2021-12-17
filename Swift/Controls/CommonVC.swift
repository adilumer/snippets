//
//  CommonVC.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

protocol CommonVCDelegate {
    func triggerViewUpdates()
}

class CommonVC: UIViewController, UIPopoverPresentationControllerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate {

    var delegate: CommonVCDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKey()
        popGestureSetup()
    }
    
    func popGestureSetup(){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipedFromLeftEdge))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
    }
    
    @objc func swipedFromLeftEdge(){
        if self.parent == nil{
            self.dismiss(animated: true, completion: nil)
        }
    }
    // Dismiss keyboard on tap outside
    func dismissKey()
    {
      let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
      view.endEditing(true)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
}
