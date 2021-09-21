//
//  FLITRegistrationViewController.swift
//  Flit iOS calculators
//
//  Created by 董静 on 7/22/21.
//

import UIKit


class FLITRegistrationViewController: FLITRegistrationBaseViewController {
    
    let keychain = KeychainSwift()
    
    struct  construct {
        static let cornerRadius: CGFloat = 4.0
    }
    
    private let errorView : FLITLoginError = {
        let view = FLITLoginError()
        view.hide()
        return view
    }()
    
    private let usernameFiled: FLITLoginTextField = {
        let field = FLITLoginTextField()
        field.setPlaceHolderText("Enter your email")
        return field
    }()
    
    private let emailDressLabel : UILabel = {
        let label = UILabel()
        label.textColor = FLITColor.flit_light_logo_title_second
        label.text = "Email Address*"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = FLITColor.flit_light_logo_mid_blue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = construct.cornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.addTarget(self,
                                 action: #selector(didTapNext),
                                 for: .touchUpInside)
        usernameFiled.delegate = self

        view.addSubview(emailDressLabel)
        view.addSubview(usernameFiled)
        view.addSubview(nextButton)
        view.addSubview(errorView)
        view.backgroundColor = .systemBackground
        self.setNewNavigationTitle(with: "Sign up")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailDressLabel.frame = CGRect(x: 50, y: view.safeAreaInsets.top + 100, width: 150, height: 30)
        usernameFiled.frame = CGRect(x: 50, y: emailDressLabel.bottom + 10, width: view.width-100, height: 40)
        nextButton.frame = CGRect(x: 50, y: view.bottom - 100, width: view.width-100, height: 40)
        errorView.frame = CGRect(x: 50, y: usernameFiled.bottom + 5, width: 150, height: 15)

    }
    
    @objc private func didTapNext(){
        
        usernameFiled.resignFirstResponder()
        
        // the format of email is incorrect
        let text = usernameFiled.text
        if text!.contains("@"), text!.contains(".") {
            // pass to next step
            let registerTwo = FLITRegistrationViewControllerTwo()
            registerTwo.setNewNavigationTitle(with: "Sign up")
            self.navigationController?.pushViewController(registerTwo, animated: true)
        }else{
            // remind user to change the email format
            errorView.show()
        }
    }
        
}

extension FLITRegistrationViewController: UITextFieldDelegate{
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // the format of email is incorrect
        let text = textField.text
        if text!.contains("@"), text!.contains(".") {
            self.navigationController?.pushViewController(FLITRegistrationViewControllerTwo(), animated: true)
        }else{
            // remind user to change the email format
            errorView.show()
            updateFocusIfNeeded()
        }
        return true
    }
}
