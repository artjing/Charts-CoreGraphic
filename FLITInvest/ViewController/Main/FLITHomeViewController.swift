//
//  FLITHomeViewController.swift
//  FLITInvest
//
//  Created by 董静 on 7/25/21.
//

import UIKit
import KeychainSwift
import BiometricAuthentication
import FirebaseAuth

class FLITHomeViewController: UIViewController {
    
    let keyChain = KeychainSwift()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        
    }
    
    func setUI(){
        view.addSubview(homeBackImage)
        view.addSubview(homeIcon)
        //view.addSubview(authLoginButton)
        view.addSubview(loginButton)
        // view.addSubview(touchIDButton)
        view.addSubview(logoutButton)
    }
    
    private let homeBackImage : UIImageView = {
        let homeBackImage = UIImageView()
        homeBackImage.image = UIImage(named: "FLIT_BLUE_GRADIENT")
        return homeBackImage
    }()
    
    private let homeIcon : UIImageView = {
        let homeIcon = UIImageView()
        homeIcon.layer.cornerRadius = 20
        homeIcon.image = UIImage(named: "FLIT Logo Square")
        return homeIcon
    }()
    
    private let touchIDButton : UIButton = {
        let touchIDButton = UIButton()
        touchIDButton.backgroundColor = FLITColor.nova_light
        touchIDButton.setTitle("TouchID Login", for: .normal)
        touchIDButton.setTitleColor(.white, for: .normal)
        touchIDButton.layer.cornerRadius = 10
        touchIDButton.addTarget(self, action: #selector(touchidLogin), for: .touchUpInside)
        return touchIDButton
    }()
    
    private let authLoginButton : UIButton = {
        let authLoginButton = UIButton()
        authLoginButton.backgroundColor = FLITColor.nova_light
        authLoginButton.setTitle("Test Phone Login", for: .normal)
        authLoginButton.setTitleColor(.white, for: .normal)
        authLoginButton.layer.cornerRadius = 10
        authLoginButton.addTarget(self, action: #selector(handleAuth), for: .touchUpInside)
        return authLoginButton
    }()
    
    private let loginButton : UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = FLITColor.nova_light
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        return loginButton
    }()
    
    private let logoutButton : UIButton = {
        let logoutButton = UIButton()
        logoutButton.backgroundColor = FLITColor.nova_light
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.layer.cornerRadius = 10
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return logoutButton
    }()
    
    @objc func logout() {
        
        // delete keychain
        keyChain.delete(FLITPreferenceKeys.FLITLoginState)
        
        // alert user
        let alert = UIAlertController(title: "Logout", message: "Are you sure to sign out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            AuthManager.shared.logOut {[weak self] success in
                if success {
                    self!.loginButton.isHidden = false
                    self!.logoutButton.isHidden = true
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func login() {
        handleLogin()
    }
    
    @objc func touchidLogin() {
        
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { (result) in
            
            switch result {
            case .success( _):
                print("Authentication Successful")
            case .failure(let error):
                print("Authentication Failed")
            }
        }
    }
    
    @objc private func handleAuth(){
        showAuthView()
    }
    
    // Check the login state
    private func handleLogin() {
        //        if let result = keyChain.get(FLITPreferenceKeys.FLITLoginState){
        //            if result != FLITPreferenceKeys.FLITLoginSucessResult {
        //                showLoginView()
        //            }
        //        }else{
        //            showLoginView()
        //        }
        
        showLoginView()
    }
    
    // show auth view
    private func showAuthView(){
        // Add auth2.0 function, add AuthViewController, and add code in delegate
        // let authVC = FLITAuthViewController()
        // self.present(authVC, animated: true)
        
        let phoneAuthVC = FLITPhoneInputViewController()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(phoneAuthVC, animated: true)
        
        
    }
    
    // show login view
    private func showLoginView(){
        
        let loginViewController = FLITLoginViewController()
        let nav = UINavigationController(rootViewController: loginViewController)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            loginButton.isHidden = true
            logoutButton.isHidden = false
        }else{
            loginButton.isHidden = false
            logoutButton.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        homeBackImage.frame = view.frame
        
        homeIcon.snp.makeConstraints { (constrain) in
            constrain.width.equalTo(80)
            constrain.height.equalTo(80)
            constrain.centerX.equalToSuperview()
            constrain.top.equalToSuperview().offset(150)
            
        }
        
//        touchIDButton.snp.makeConstraints { (constrain) in
//            constrain.width.equalToSuperview().multipliedBy(0.8)
//            constrain.height.equalTo(50)
//            constrain.centerX.equalToSuperview()
//            constrain.bottom.equalToSuperview().offset(-220)
//        }
        
//        authLoginButton.snp.makeConstraints { (constrain) in
//            constrain.width.equalToSuperview().multipliedBy(0.8)
//            constrain.height.equalTo(50)
//            constrain.centerX.equalToSuperview()
//            constrain.bottom.equalToSuperview().offset(-150)
//        }
        
        loginButton.snp.makeConstraints { (constrain) in
            constrain.width.equalToSuperview().multipliedBy(0.8)
            constrain.height.equalTo(50)
            constrain.centerX.equalToSuperview()
            constrain.bottom.equalToSuperview().offset(-80)
        }
        
        logoutButton.snp.makeConstraints { (constrain) in
            constrain.width.equalToSuperview().multipliedBy(0.8)
            constrain.height.equalTo(50)
            constrain.centerX.equalToSuperview()
            constrain.bottom.equalToSuperview().offset(-80)
        }
        
    }
}
