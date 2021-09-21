//
//  FLITLoginTextField.swift
//  FLITInvest
//
//  Created by 董静 on 8/19/21.
//

import UIKit

class FLITLoginTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        autocapitalizationType = .none
        autocorrectionType = .no
        layer.masksToBounds = true
        
        backgroundColor = FLITColor.flit_login_textFeild_back
        backgroundColor = .secondarySystemBackground

        
    }
    
    func setPlaceHolderText(_ text: String){
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: FLITColor.flit_placeholder,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)
        ]
        attributedPlaceholder = NSAttributedString(string: text, attributes:attributes)
    }

}
