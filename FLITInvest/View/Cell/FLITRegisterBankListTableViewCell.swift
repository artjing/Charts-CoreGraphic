//
//  FLITRegisterBankListTableViewCell.swift
//  FLITInvest
//
//  Created by 董静 on 8/27/21.
//

import UIKit

class FLITRegisterBankListTableViewCell: UITableViewCell {

    static let identifier = "FLITRegisterBankListTableViewCell"
    
    private let icon : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let bankTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = FLITColor.text_nuetral_black
        return label
    }()
    
    private let line : UIView = {
        let view = UIView()
        view.backgroundColor = FLITColor.login_textfiled_line
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(icon)
        contentView.addSubview(bankTitle)
        contentView.addSubview(line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        icon.snp.makeConstraints { (con) in
            con.left.equalToSuperview().offset(30)
            con.top.equalToSuperview().offset(14)
            con.width.equalTo(34)
            con.height.equalTo(34)
        }
        
        bankTitle.snp.makeConstraints { (con) in
            con.left.equalTo(icon.snp.right).offset(14)
            con.top.equalTo(icon.snp.top)
            con.width.equalToSuperview().multipliedBy(0.6)
            con.height.equalTo(34)
        }
        
        line.snp.makeConstraints { (con) in
            con.height.equalTo(1)
            con.left.equalToSuperview().offset(30)
            con.right.equalToSuperview().offset(-30)
            con.bottom.equalToSuperview()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(model: bankModel) {
        icon.image = UIImage(named: model.bankImages)
        bankTitle.text = model.bankName
    }
}
