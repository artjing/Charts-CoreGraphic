//
//  FLITLoginError.swift
//  FLITInvest
//
//  Created by 董静 on 8/21/21.
//

import UIKit

class FLITLoginError: UIView {

    private let errorLabel : UILabel = {
        let errorView = UILabel()
        errorView.text = "Invalid email address"
        errorView.textColor = .red
        errorView.textAlignment = .left
        errorView.font = UIFont.systemFont(ofSize: 13)
        errorView.textColor = FLITColor.flit_error_red
        return errorView
    }()
    
    private let errorIcon : UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "errorIcon")
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        errorIcon.snp.makeConstraints { (con) in
            con.left.equalToSuperview()
            con.top.equalToSuperview()
            con.width.equalTo(22)
            con.height.equalTo(22)
        }
        errorLabel.sizeToFit()
        errorLabel.snp.makeConstraints { (con) in
            con.left.equalTo(errorIcon.snp.right).offset(10)
            con.centerY.equalTo(errorIcon.snp.centerY)
        }
    }
    
    func configure() {
        addSubview(errorIcon)
        addSubview(errorLabel)
    }
    
    func hide(){
        errorIcon.isHidden = true
        errorLabel.isHidden = true
    }
    
    func show(){
        errorIcon.isHidden = false
        errorLabel.isHidden = false
    }
    
    func error(_ text: String) {
        errorLabel.text = text
    }
}
