//
//  FLITRegisterBankInfoViewController.swift
//  FLITInvest
//
//  Created by 董静 on 8/26/21.
//

import UIKit

class FLITRegisterBankInfoViewController: FLITRegistrationBaseViewController {
    
    var currentBank: bankModel?
    
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
        label.text = "Online ID*"
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
        label.text = "Password*"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let lastnameFiled: FLITLoginTextField = {
        let field = FLITLoginTextField()
        field.placeholder = ""
        return field
    }()

    private let TopIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Chase.png")
        return imageView
    }()
    
    private let TopTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = FLITColor.text_nuetral_black
        label.text = "Chase Bank"
        return label
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
                
        // Navigation title
        currentStep = 5
        setNewNavigationTitle(with: "Plaid")
        view.backgroundColor = .white
        
        // add all the views
        view.addSubview(TopIcon)
        view.addSubview(TopTitle)
        view.addSubview(firstnameLabel)
        view.addSubview(firstnameFiled)
        view.addSubview(secondnameFiled)
        view.addSubview(secondnameLabel)
        view.addSubview(lastnameFiled)
        view.addSubview(nextButton)
        
        view.backgroundColor = .systemBackground

        guard let currentBank = currentBank else {
            return
        }
        
        TopIcon.image = UIImage(named: currentBank.bankImages)
        TopTitle.text = currentBank.bankName
        
    }

    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        TopIcon.snp.makeConstraints { (con) in
            con.centerX.equalToSuperview().offset(-50)
            con.top.equalToSuperview().offset(200)
            con.width.equalTo(60)
            con.height.equalTo(60)
        }
        
        TopTitle.snp.makeConstraints { (con) in
            con.centerX.equalToSuperview().offset(30)
            con.centerY.equalTo(TopIcon.snp.centerY)
            con.top.equalToSuperview().offset(200)
            con.width.equalTo(100)
            con.height.equalTo(20)
        }
        
        firstnameLabel.frame = CGRect(x: 50,
                                      y: view.safeAreaInsets.top + 180,
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
        
        nextButton.frame = CGRect(x: 50, y: view.bottom - 100, width: view.width-100, height: 40)
        
    }
    
    @objc private func didTapNext(){
        firstnameFiled.resignFirstResponder()

        self.navigationController?.pushViewController(FLITRegisterConfirmPortfolioLastViewController(), animated: true)
    }
    
    func config(bank: bankModel){
        currentBank = bank
        view.setNeedsDisplay()
    }
}

extension FLITRegisterBankInfoViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
