//
//  FLITLoginViewController.swift
//  Flit iOS calculators
//
//  Created by 董静 on 7/22/21.
//

import SafariServices
import UIKit
import FirebaseAuth
import BiometricAuthentication

class FLITLoginViewController: UIViewController {
    
    // for store the login state and password
    let keychain = KeychainSwift()

    struct construct {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let passwordLine : UIView = {
        let line = UIView()
        line.backgroundColor = FLITColor.flit_light_blue
        return line
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        // field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = construct.cornerRadius
        return field
    }()
    
    private let finger: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "fingerPrint"), for: .normal)
        button.addTarget(self, action: #selector(fingerPrint), for: .touchUpInside)
        return button
    }()
    
    private let userNameLine : UIView = {
        let line = UIView()
        line.backgroundColor = FLITColor.flit_light_blue
        return line
    }()
    
    private let usernameFiled: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = construct.cornerRadius
        return field
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = FLITColor.flit_light_mid_blue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = construct.cornerRadius
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("terms", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("New account", for: .normal)
        return button
    }()
    
    private let forgetPasswordButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("Forgot password", for: .normal)
        button.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
        return button
    }()
    
    private let phoneLoginButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("Phone Login", for: .normal)
        button.addTarget(self, action: #selector(phoneLogin), for: .touchUpInside)
        return button
    }()
    
    private let headView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backgroundImage = UIImageView(image: UIImage(named: "FLIT Logo Final Bold"))
        backgroundImage.sizeToFit()
        view.contentMode = .scaleAspectFit
        view.addSubview(backgroundImage)
        return view
    }()
    
    private let logo: UILabel = {
        let logo = UILabel()
        logo.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        logo.text = "SIGN IN"
        logo.textAlignment = .center
        logo.textColor = FLITColor.flit_light_logo_mid_blue
        return logo
    }()
    
    private func configureHeaderView(){
        guard headView.subviews.count == 1 else{
            return
        }
        guard let backgroundView = headView.subviews.first as UIView? else{
            return
        }
        backgroundView.frame = headView.bounds
        
        let imageview = UIImageView(image: UIImage(named: ""))
        headView.addSubview(imageview)
        imageview.contentMode = .scaleAspectFit
        imageview.frame = CGRect(x: headView.width/4.0, y: view.safeAreaInsets.top, width: headView.width/2.0, height: headView.height - view.safeAreaInsets.top)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        createAccountButton.addTarget(self,
                              action: #selector(didTapCreateAccountButton),
                              for: .touchUpInside)
        termsButton.addTarget(self,
                              action: #selector(didTapTermButton),
                              for: .touchUpInside)
        usernameFiled.delegate = self
        passwordField.delegate = self
        view.backgroundColor = .systemBackground
        
        addSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        headView.frame = CGRect(x: (view.width - 178) * 0.5,
                                y: view.safeAreaInsets.top + 100,
                                width:178,
                                height: 54)
        
        logo.frame = CGRect(x: 0,
                            y: headView.bottom + 10,
                            width: view.width,
                            height:100)
        
        usernameFiled.frame = CGRect(x: 25,
                                     y: logo.bottom + 20,
                                     width: view.width - 50,
                                     height: 52.0)
        
        userNameLine.frame = CGRect(x: 30,
                                    y: usernameFiled.bottom + 1,
                                    width: view.width - 60,
                                    height: 1)
        
        passwordField.frame = CGRect(x: 25,
                                     y: usernameFiled.bottom + 10,
                                     width: view.width - 50,
                                     height: 52.0)
        
        finger.frame = CGRect(x: passwordField.right - 40,
                              y: passwordField.bottom - 40,
                              width: 30,
                              height: 30)
        
        passwordLine.frame = CGRect(x: 30,
                                    y: passwordField.bottom + 1,
                                    width: view.width - 60,
                                    height: 1)
        
        loginButton.frame = CGRect(x: 100,
                                   y: passwordField.bottom + 100,
                                   width: view.width - 200,
                                   height: 40.0)

        createAccountButton.frame = CGRect(x: 25,
                                     y: loginButton.bottom + 10,
                                     width: view.width - 50,
                                     height: 30.0)
        
        termsButton.frame = CGRect(x: 25,
                                   y: view.bottom - view.safeAreaInsets.top - 60,
                                     width: view.width - 50,
                                     height: 50)
        
        forgetPasswordButton.frame = CGRect(x: 10,
                                            y: passwordField.bottom + 10,
                                            width: 150,
                                            height: 30.0)
        
        phoneLoginButton.frame = CGRect(x: view.width - 150,
                                        y: passwordField.bottom + 10,
                                        width: 150,
                                        height: 30.0)
        
        configureHeaderView()

    }
    
    private func addSubviews(){
        
        view.addSubview(headView)
        view.addSubview(logo)
        view.addSubview(usernameFiled)
        view.addSubview(userNameLine)
        view.addSubview(passwordField)
        view.addSubview(passwordLine)
        view.addSubview(finger)
        view.addSubview(loginButton)
        //view.addSubview(termsButton)
        view.addSubview(phoneLoginButton)
        view.addSubview(createAccountButton)
        view.addSubview(forgetPasswordButton)
    }
    
    @objc private func didTapLoginButton() {
        
        passwordField.resignFirstResponder()
        usernameFiled.resignFirstResponder()
        
        // simulate login success
        self.keychain.set(FLITPreferenceKeys.FLITLoginSucessResult, forKey: FLITPreferenceKeys.FLITLoginState)
        
        // check the input text are not empty
        // password and email
        guard let username = usernameFiled.text, !username.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else{
            let alert = UIAlertController(title: "Login error", message: "Passswor or email are incorrect. ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        // the format of email is incorrect
        var email : String?
        var currentpassword : String?
        if username.contains("@"), username.contains("."){
            email = username
            currentpassword = password
        }else{
            // remind user to change the email format
            let alert = UIAlertController(title: "Log In Error", message: "The email address is not correct", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: nil))
            present(alert, animated: true)

        }
        
        // Login request
        AuthManager.shared.loginWith(email: email, password: currentpassword) { success in
            
            // Save token in mainThread
            DispatchQueue.main.async {
                if success {
                    self.keychain.set(FLITPreferenceKeys.FLITLoginSucessResult, forKey: FLITPreferenceKeys.FLITLoginState)
                    self.dismiss(animated: true, completion: nil)
                    
                    // login sucess
                    let alert = UIAlertController(title: "Login", message: "Login Success", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    }))
                    self.present(alert, animated: true)
                }
                else{
                    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc private func didTapCreateAccountButton(){
        let createvc = FLITRegistrationViewController()
        self.navigationController?.pushViewController(createvc, animated: true)
    }
    
    @objc private func didTapTermButton() {
        guard let url = URL(string: "") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func fingerPrint() {
        
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { (result) in
            
            switch result {
            case .success( _):
                print("Authentication Successful")
            case .failure(let error):
                print("Authentication Failed")
            }
        }
    }
    
    @objc func phoneLogin() {
        let phoneAuthVC = FLITPhoneInputViewController()
        navigationController?.pushViewController(phoneAuthVC, animated: true)
    }
    
    @objc func forgetPassword() {
        let forgetPassVC = FLITRegistrationViewControllerTwo()
        forgetPassVC.setNewNavigationTitle(with: "Reset Password")
        navigationController?.pushViewController(forgetPassVC, animated: true)
    }
}

extension FLITLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameFiled{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}
