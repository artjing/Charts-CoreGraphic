//
//  FLITPortfolioTwoTableViewCell.swift
//  FLITInvest
//
//  Created by 董静 on 9/6/21.
//

import UIKit

class FLITPortfolioTwoTableViewCell: UITableViewCell {

    static let identifier = "FLITPortfolioTwoTableViewCell"
    
    // private view
    
    private let country : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let stockNum : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let stockRate : UIView = {
        let view = UIView()
        view.backgroundColor = FLITColor.flit_label_back
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private let stockLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .right
        label.text = ">"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(country)
        contentView.addSubview(stockNum)
        contentView.addSubview(stockRate)
        contentView.addSubview(stockLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confic(_ model : FLITPortfolioContryModel) {
        country.text = model.country
        stockNum.text = "\(model.rate)"
        stockRate.snp.makeConstraints({ (con) in
            con.width.equalTo(model.number * 50)
        })
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        country.snp.makeConstraints { (con) in
            con.left.equalToSuperview().offset(0)
            con.centerY.equalToSuperview()
            con.width.equalTo(60)
            con.height.equalTo(20)
        }
        
        stockRate.snp.makeConstraints { (con) in
            con.left.equalTo(country.snp.right).offset(5)
            con.centerY.equalToSuperview()
            con.width.equalTo(100)
            con.height.equalTo(20)
        }

        stockLabel.snp.makeConstraints { (con) in
            con.right.equalToSuperview().offset(0)
            con.centerY.equalToSuperview()
            con.width.equalTo(10)
            con.height.equalTo(20)
        }
        
        stockNum.snp.makeConstraints { (con) in
            con.right.equalTo(stockLabel.snp.left).offset(-50)
            con.centerY.equalToSuperview()
            con.width.equalTo(100)
            con.height.equalTo(20)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
