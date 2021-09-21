//
//  FLITPhoneInputViewController.swift
//  FLITInvest
//
//  Created by 董静 on 8/19/21.
//

import UIKit

class FLITPhoneInputViewController: FLITRegistrationBaseViewController {

    struct construct {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let phoneNumberField: UITextField = {
        let field = UITextField()
        // field.isSecureTextEntry = true
        field.placeholder = "Phone Number"
        field.keyboardType = .numberPad
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        return field
    }()
    
    private let verifyButton:UIButton = {
        let button = UIButton()
        button.setTitle("Verify", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = FLITColor.nova_gray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = construct.cornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNewNavigationTitle(with: "Phone Login")
        
        view.backgroundColor = .white
        view.addSubview(phoneNumberField)
        view.addSubview(verifyButton)
        verifyButton.addTarget(self,
                              action: #selector(didTapPhonVeifyButton),
                              for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        phoneNumberField.frame = CGRect(x: 50,
                                     y: view.top + 250,
                                     width: view.width - 100,
                                     height: 52.0)
        
        verifyButton.frame = CGRect(x: 50,
                                   y: phoneNumberField.bottom + 10,
                                   width: view.width - 100,
                                   height: 40)
    }
    
    @objc func didTapPhonVeifyButton() {
        
        let phoneAuth = FLITPhoneAuthViewController()
        phoneAuth.phoneNumer = phoneNumberField.text!
        self.navigationController?.pushViewController(phoneAuth, animated: true)
    }
}
