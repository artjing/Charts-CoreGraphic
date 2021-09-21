//
//  FLITCheckButton.swift
//  FLITInvest
//
//  Created by 董静 on 8/20/21.
//

import UIKit


/// This is a customized button for checking statues
/// Used in login/register page

class FLITCheckButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){

        setImage(UIImage(named: "check_button_gray"), for: .normal)
        setImage(UIImage(named: "check_button_selected"), for: .selected)
        isSelected = false
    }
    
    func tagge(_ isOn: Bool) {
        if isOn{
            isSelected = true
        }else{
            isSelected = false
        }
    }
}
