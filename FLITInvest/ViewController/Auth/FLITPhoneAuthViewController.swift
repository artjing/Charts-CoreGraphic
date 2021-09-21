//
//  FLITPhoneAuthViewController.swift
//  FLITInvest
//
//  Created by 董静 on 8/18/21.
//

import UIKit
import FirebaseAuth


class FLITPhoneAuthViewController: UIViewController {
    
    var phoneNumer: String = ""
    
    private var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.text = "Please Enter the code"
        return titleLabel
    }()
    
    private var phoneTextFiled : FLITPhoneLoginTextFiled = {
        let phoneTextFiled = FLITPhoneLoginTextFiled()
        phoneTextFiled.backgroundColor = .white
        return phoneTextFiled
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(phoneTextFiled)
        phoneTextFiled.configure()
        
        // Firebase verify phone number
        verifyPhoneNum()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.snp.makeConstraints { (constrain) in
            constrain.top.equalToSuperview().offset(100)
            constrain.width.equalToSuperview().multipliedBy(0.8)
            constrain.centerX.equalToSuperview()
            constrain.height.equalTo(150)
        }
        phoneTextFiled.snp.makeConstraints { (constrain) in
            constrain.width.equalToSuperview().multipliedBy(0.8)
            constrain.centerX.equalToSuperview()
            constrain.top.equalTo(titleLabel.bottom).offset(200)
            constrain.height.equalTo(60)
        }
    }
    
    func verifyPhoneNum() {
        var verificationID = ""
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+16615106763", uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error)
                    return
                }
                // Sign in using the verificationID and the code sent to the user
                // ...
                let credential = PhoneAuthProvider.provider().credential(
                    withVerificationID: verificationID!,
                    verificationCode: "123456"
                )
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        let authError = error as NSError
                        // User is signed in
                        // ...
                    }
                }
            }
    }
    
}
