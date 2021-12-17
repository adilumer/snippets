//
//  StarRating.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import SwiftIcons

@IBDesignable class StarRating: UIStackView {
    
    //Properties
    private var ratingButtons = [UIButton]()
    private var label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 21))
    
    @IBInspectable var isEditable = true{
        didSet {
            if !isEditable{ isUserInteractionEnabled = false }
        }
    }
    
    var rating = 0.0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    var commentCount = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var hideTextControls = false{
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 14.0, height: 14.0){
        didSet {
            setupStars()
        }
    }
    
    @IBInspectable var starCount: Int = 5{
        didSet {
            setupStars()
        }
    }
    
    //Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        
        if !isEditable {
            return
        }
        
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        rating = Double(selectedRating)
        /*if selectedRating == Int(rating) {
         // If the selected star represents the current rating, reset the rating to 0.
         rating = 0
         } else {
         // Otherwise set the rating to the selected star
         rating = Double(selectedRating)
         }*/
    }
    
    //Pvt
    private func setupStars() {
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
            let button = UIButton()
            let img = UIImage.init(icon: .fontAwesomeRegular(.star), size: starSize, textColor: ProjectDefaults.DarkerPrimary, backgroundColor: .white)
            let imgSel = UIImage.init(icon: .fontAwesomeSolid(.star), size: starSize, textColor: ProjectDefaults.DarkerPrimary, backgroundColor: .white)
            button.setImage(img, for: .normal)
            button.setImage(imgSel, for: .selected)
            button.tintColor = ProjectDefaults.starColor
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.addTarget(self, action: #selector(StarRating.ratingButtonTapped(button:)), for: .touchUpInside)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        
        label.font = UIFont(name: "OpenSans-Regular", size: (starSize.height - 1))
        label.textColor = .black
        addArrangedSubview(label)
        
        updateButtonSelectionStates()
        
    }
    
    func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < Int(rating)
        }
        
        label.isHidden = hideTextControls
        
        if commentCount == 0 {
            label.text = String(rating)
        }else{
            label.text = String(rating) + "  (" + String(commentCount) + ")"
        }
        
    }
    
    
    
}
