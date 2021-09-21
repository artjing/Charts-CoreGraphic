//
//  Utilities.swift
//  Flit iOS calculators
//
//  Created by Brian Kim on 7/15/21.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        
        iv.image = image
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(height: 24, width: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tF = UITextField()
        tF.textColor = .white
        tF.font = .systemFont(ofSize: 16)
        
        //attributed placeholder
        tF.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tF
        
    }
    
    func attributedButton(_ firstPart: String, _ SecondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: SecondPart, attributes:
                                                    [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
                                                     NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
    
    func infoAttributedButton(_ firstPart: String, _ SecondPart: String, _ ThirdPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.SFProRegular, size: 19) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.black])
        
        attributedTitle.append(NSAttributedString(string: SecondPart, attributes:
                                                    [NSAttributedString.Key.font: UIFont(name: Fonts.SFProRegular, size: 19) as Any,
                                                     NSAttributedString.Key.foregroundColor: UIColor.babyBlue]))
        
        attributedTitle.append(NSAttributedString(string: ThirdPart, attributes:
                                                    [NSAttributedString.Key.font: UIFont(name: Fonts.SFProRegular, size: 19) as Any,
                                                     NSAttributedString.Key.foregroundColor: UIColor.black]))
        
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
        
    }
    
    
    func privatePolicyAttributedButton(_ firstPart: String, _ SecondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        attributedTitle.append(NSAttributedString(string: SecondPart, attributes:
                                                    [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                     NSAttributedString.Key.foregroundColor: UIColor.babyBlue]))
        
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
    
}
