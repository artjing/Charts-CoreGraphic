//
//  FLITRegistrationViewControllerTwo.swift
//  FLITInvest
//
//  Created by 董静 on 8/19/21.
//


import UIKit


class FLITRegistrationViewControllerTwo: FLITRegistrationBaseViewController {
    
    let keychain = KeychainSwift()
    
    var isCheckedRight = false
    
    struct  construct {
        static let cornerRadius: CGFloat = 4.0
    }

    private let passwordFiled: FLITLoginTextField = {
        let field = FLITLoginTextField()
        field.setPlaceHolderText("Enter your password")
        return field
    }()
    
    private let confirmPasswordFiled: FLITLoginTextField = {
        let field = FLITLoginTextField()
        field.setPlaceHolderText("Confirm your password")
        return field
    }()
    
    private let errorView : FLITLoginError = {
        let errorView = FLITLoginError()
        errorView.hide()
        errorView.error("Different password")
        return errorView
    }()
    
    private let passwordsLabel : UILabel = {
        let label = UILabel()
        label.textColor = FLITColor.flit_light_logo_title_second
        label.text = "Passsword*"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let confirmPasswordsLabel : UILabel = {
        let label = UILabel()
        label.textColor = FLITColor.flit_light_logo_title_second
        label.text = "Confirm Passsword*"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    // Checking views
    private let checkOneIcon : FLITCheckButton = {
        let checkOne = FLITCheckButton()
        return checkOne
    }()
    
    private let checkOneLabel : UILabel = {
        let checkOneLabel = UILabel()
        checkOneLabel.font = UIFont.systemFont(ofSize: 12)
        checkOneLabel.textColor = .black
        checkOneLabel.textAlignment = .left
        checkOneLabel.text = "Minimum 8 characters"
        return checkOneLabel
    }()
    
    private let checkTwoIcon : FLITCheckButton = {
        let checkOne = FLITCheckButton()
        return checkOne
    }()
    
    private let checkTwoLabel : UILabel = {
        let checkOneLabel = UILabel()
        checkOneLabel.font = UIFont.systemFont(ofSize: 12)
        checkOneLabel.textColor = .black
        checkOneLabel.textAlignment = .left
        checkOneLabel.text = "One uppercase and lowercase character"
        return checkOneLabel
    }()
    
    private let checkThreeIcon : FLITCheckButton = {
        let checkOne = FLITCheckButton()
        return checkOne
    }()
    
    private let checkThreeLabel : UILabel = {
        let checkOneLabel = UILabel()
        checkOneLabel.font = UIFont.systemFont(ofSize: 12)
        checkOneLabel.textColor = .black
        checkOneLabel.textAlignment = .left
        checkOneLabel.text = "One Number"
        return checkOneLabel
    }()
    
    private let checkFourIcon : FLITCheckButton = {
        let checkOne = FLITCheckButton()
        return checkOne
    }()
    
    private let checkFourLabel : UILabel = {
        let checkOneLabel = UILabel()
        checkOneLabel.font = UIFont.systemFont(ofSize: 12)
        checkOneLabel.textColor = .black
        checkOneLabel.textAlignment = .left
        checkOneLabel.text = "One specific character"
        return checkOneLabel
    }()
    
    private let registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = FLITColor.nova_gray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = construct.cornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.addTarget(self,
                                 action: #selector(didTapRegister),
                                 for: .touchUpInside)
        passwordFiled.delegate = self
        confirmPasswordFiled.delegate = self
        
        currentStep = 2
        
        // Navigation title

        // add all the text filed and button
        view.addSubview(passwordFiled)
        view.addSubview(confirmPasswordFiled)
        view.addSubview(passwordsLabel)
        view.addSubview(confirmPasswordsLabel)
        view.addSubview(errorView)
        view.addSubview(registerButton)
        
        // add all check icons
        view.addSubview(checkOneIcon)
        view.addSubview(checkOneLabel)
        view.addSubview(checkTwoIcon)
        view.addSubview(checkTwoLabel)
        view.addSubview(checkThreeIcon)
        view.addSubview(checkThreeLabel)
        view.addSubview(checkFourIcon)
        view.addSubview(checkFourLabel)
        
        view.backgroundColor = .systemBackground
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        passwordsLabel.frame = CGRect(x: 50,
                                      y: view.safeAreaInsets.top + 100,
                                      width: 150,
                                      height: 30)
        
        passwordFiled.frame = CGRect(x: 50,
                                     y: passwordsLabel.bottom + 10,
                                     width: view.width-100,
                                     height: 40)
        
        confirmPasswordsLabel.frame = CGRect(x: 50,
                                             y: passwordFiled.bottom + 120,
                                             width: view.width - 150,
                                             height: 30)
        
        confirmPasswordFiled.frame = CGRect(x: 50,
                                            y: confirmPasswordsLabel.bottom + 10,
                                            width: view.width-100,
                                            height: 40)
        
        errorView.frame = CGRect(x: 50,
                                 y: confirmPasswordFiled.bottom + 10,
                                 width: 200,
                                 height: 20)
        
        registerButton.frame = CGRect(x: 50,
                                      y: view.bottom - 100,
                                      width: view.width-100,
                                      height: 40)
        
        // check out labe layout
        checkOneIcon.frame = CGRect(x: 50,
                                     y: passwordFiled.bottom + 10,
                                     width: 12,
                                     height: 12)
        
        checkOneLabel.frame = CGRect(x: checkOneIcon.right + 10,
                                     y: passwordFiled.bottom + 10,
                                     width: view.width - 100,
                                     height: 15)
        
        checkOneLabel.sizeToFit()
        
        checkOneLabel.snp.makeConstraints { con in
            con.centerY.equalTo(checkOneIcon)
        }
        
        // two
        
        checkTwoIcon.frame = CGRect(x: 50,
                                     y: checkOneIcon.bottom + 10,
                                     width: 12,
                                     height: 12)
        
        checkTwoLabel.frame = CGRect(x: checkTwoIcon.right + 10,
                                     y: checkOneIcon.bottom + 10,
                                     width: view.width - 100,
                                     height: 15)
        
        checkTwoLabel.sizeToFit()
        
        checkTwoLabel.snp.makeConstraints { con in
            con.centerY.equalTo(checkTwoIcon)
        }
        
        // three
        checkThreeIcon.frame = CGRect(x: 50,
                                     y: checkTwoLabel.bottom + 10,
                                     width: 12,
                                     height: 12)
        
        checkThreeLabel.frame = CGRect(x: checkThreeIcon.right + 10,
                                     y: checkTwoLabel.bottom + 10,
                                     width: view.width - 100,
                                     height: 15)
        
        checkThreeLabel.sizeToFit()
        
        checkThreeLabel.snp.makeConstraints { con in
            con.centerY.equalTo(checkThreeIcon)
        }
        
        // four
        
        checkFourIcon.frame = CGRect(x: 50,
                                     y: checkThreeLabel.bottom + 10,
                                     width: 12,
                                     height: 12)
        
        checkFourLabel.frame = CGRect(x: checkFourIcon.right + 10,
                                     y: checkThreeLabel.bottom + 10,
                                     width: view.width - 100,
                                     height: 15)
        
        checkFourLabel.sizeToFit()
        
        checkFourLabel.snp.makeConstraints { con in
            con.centerY.equalTo(checkFourIcon)
        }
        
        
    }
    
    @objc private func didTapRegister(){
        passwordFiled.resignFirstResponder()
        self.navigationController?.pushViewController(FLITRegistrationViewControllerThree(), animated: true)
    }
    
    func validatePassword(_ password: String) -> [Int]{
        
        
        var results = [Int]()
        let lengthRule = "^[\\x21-\\x7E]{8,16}$$"
        let regexlength = NSPredicate(format: "SELF MATCHES %@",lengthRule)
        if regexlength.evaluate(with: password) == true {
            results.append(1)
        }
        
        // both capital and small letter
        var small = false
        var capital = false
        
        let capitalletterRule = "^.*[A-Z]+.*$"
        let regexcapitalletter = NSPredicate(format: "SELF MATCHES %@",capitalletterRule)
        if regexcapitalletter.evaluate(with: password) == true {
            capital = true
        }
        
        let smallletterRule = "^.*[a-z]+.*$"
        let regexsmallletter = NSPredicate(format: "SELF MATCHES %@",smallletterRule)
        if regexsmallletter.evaluate(with: password) == true {
            small = true
        }
        
        if small && capital {
            results.append(2)
        }
        
        let numberRule = "^.*[0-9]+.*$"
        let regexNumber = NSPredicate(format: "SELF MATCHES %@",numberRule)
        if regexNumber.evaluate(with: password) == true {
            results.append(3)
        }
        
        let specialRule = "^.*[!@#$&*]+.*$"
        let regexSpecial = NSPredicate(format: "SELF MATCHES %@",specialRule)
        if regexSpecial.evaluate(with: password) == true {
            results.append(4)
        }
        
        return results

    }
    
    
    // check button green/gray
    func updateCheck(_ results: [Int]){
        
        if results.contains(1){
            checkOneIcon.tagge(true)
        }else {
            checkOneIcon.tagge(false)
        }
        
        if results.contains(2){
            checkTwoIcon.tagge(true)
        }else {
            checkTwoIcon.tagge(false)
        }
        
        if results.contains(3){
            checkThreeIcon.tagge(true)
        }else {
            checkThreeIcon.tagge(false)
        }
        
        if results.contains(4){
            checkFourIcon.tagge(true)
        }else {
            checkFourIcon.tagge(false)
        }
        
        if results.count == 4 {
            isCheckedRight = true
        }
    }
    
}

extension FLITRegistrationViewControllerTwo: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == confirmPasswordFiled {
            guard textField.text == passwordFiled.text else {
                errorView.show()
                return true
            }
        }
        errorView.hide()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == passwordFiled {
            let text = textField.text!
            let results = validatePassword(text)
            updateCheck(results)
        }
        
        if isCheckedRight && !confirmPasswordFiled.text!.isEmpty {
            registerButton.backgroundColor = FLITColor.flit_light_logo_mid_blue
        }else{
            registerButton.backgroundColor = FLITColor.flit_login_textFeild_back
        }
    }
}
