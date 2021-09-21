//
//  FLITRegistrationViewControllerThree.swift
//  FLITInvest
//
//  Created by 董静 on 8/20/21.
//

import UIKit

class FLITRegistrationViewControllerThree: FLITRegistrationBaseViewController {

    
    struct  construct {
        static let cornerRadius: CGFloat = 4.0
    }

    private let firstnameFiled: FLITLoginTextField = {
        let field = FLITLoginTextField()
        return field
    }()
    
    private let firstnameLabel : UILabel = {
        let label = UILabel()
        label.textColor = FLITColor.flit_light_logo_title_second
        label.text = "First Name*"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let secondnameFiled: FLITLoginTextField = {
        let field = FLITLoginTextField()
        return field
    }()

    private let secondnameLabel : UILabel = {
        let label = UILabel()
        label.textColor = FLITColor.flit_light_logo_title_second
        label.text = "Middle Initial*"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let lastnameFiled: FLITLoginTextField = {
        let field = FLITLoginTextField()
        field.placeholder = ""
        return field
    }()

    private let lastnameLabel : UILabel = {
        let label = UILabel()
        label.textColor = FLITColor.flit_light_logo_title_second
        label.text = "Last Name*"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let TopButton:UIButton = {
        let button = UIButton()
        button.setTitle("Why we need it ?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(FLITColor.flit_light_logo_mid_blue, for: .normal)
        button.backgroundColor = .white
        return button
    }()

    private let nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = FLITColor.flit_light_logo_mid_blue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = construct.cornerRadius
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentStep = 3
        
        // Navigation title
        self.setNewNavigationTitle(with: "Your legal name")
        
        // add all the views
        view.addSubview(TopButton)
        view.addSubview(firstnameLabel)
        view.addSubview(firstnameFiled)
        view.addSubview(secondnameFiled)
        view.addSubview(secondnameLabel)
        view.addSubview(lastnameLabel)
        view.addSubview(lastnameFiled)
        view.addSubview(nextButton)
        
        view.backgroundColor = .systemBackground

    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        TopButton.snp.makeConstraints { (con) in
            con.centerX.equalToSuperview()
            con.top.equalToSuperview().offset(200)
            con.width.equalTo(200)
            con.height.equalTo(20)
        }
        
        firstnameLabel.frame = CGRect(x: 50,
                                      y: view.safeAreaInsets.top + 160,
                                      width: 150,
                                      height: 30)
        
        firstnameFiled.frame = CGRect(x: 50,
                                      y: firstnameLabel.bottom + 10,
                                      width: view.width-100,
                                      height: 40)
        
        secondnameLabel.frame = CGRect(x: 50,
                                      y: firstnameFiled.bottom + 10,
                                      width: 150,
                                      height: 30)
        
        secondnameFiled.frame = CGRect(x: 50,
                                      y: secondnameLabel.bottom + 10,
                                      width: view.width-100,
                                      height: 40)
        
        lastnameLabel.frame = CGRect(x: 50,
                                     y: secondnameFiled.bottom + 10,
                                      width: 150,
                                      height: 30)
        
        lastnameFiled.frame = CGRect(x: 50,
                                      y: lastnameLabel.bottom + 10,
                                      width: view.width-100,
                                      height: 40)
        
        nextButton.frame = CGRect(x: 50, y: view.bottom - 100, width: view.width-100, height: 40)
    }
    
    @objc private func didTapNext(){
        firstnameFiled.resignFirstResponder()
        self.navigationController?.pushViewController(FLITRegisterChooseBankViewController(), animated: true)
        }
}

extension FLITRegistrationViewControllerThree: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
