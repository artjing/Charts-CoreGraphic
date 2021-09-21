//
//  FLITPortfolioTableViewCell.swift
//  FLITInvest
//
//  Created by 董静 on 9/6/21.
//

import UIKit

class FLITPortfolioTableViewCell: UITableViewCell {

    static let identifier = "FLITPortfolioTableViewCell"
    
    // private view
    
    private let stockName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let stockNum : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let stockRate : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = FLITColor.flit_gray_label
        label.textAlignment = .right
        return label
    }()
    
    private let stockLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = FLITColor.flit_label_back_green
        label.layer.cornerRadius = 5
        return label
    }()
    
    private let line : UIView = {
        let view = UIView()
        view.backgroundColor = FLITColor.flit_light_gray_label
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stockName)
        contentView.addSubview(stockNum)
        contentView.addSubview(stockRate)
        contentView.addSubview(stockLabel)
        contentView.addSubview(line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(_ model : FLITPortfolioModel) {
        stockName.text = model.name
        stockNum.text = model.number
        stockRate.text = model.rate
        stockLabel.text = model.tag
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        stockName.snp.makeConstraints { (con) in
            con.left.equalToSuperview().offset(0)
            con.top.equalToSuperview().offset(10)
            stockName.sizeToFit()
        }
        stockLabel.snp.makeConstraints { (con) in
            con.left.equalToSuperview().offset(0)
            con.top.equalTo(stockName.snp.bottom).offset(5)
            stockLabel.sizeToFit()

        }
        stockNum.snp.makeConstraints { (con) in
            con.right.equalToSuperview().offset(0)
            con.top.equalToSuperview().offset(10)
            con.width.equalTo(contentView).multipliedBy(0.5)
            con.height.equalTo(20)
        }
        stockRate.snp.makeConstraints { (con) in
            con.right.equalToSuperview().offset(0)
            con.top.equalTo(stockNum.snp.bottom).offset(5)
            con.width.equalTo(contentView).multipliedBy(0.5)
            con.height.equalTo(20)
        }
        line.snp.makeConstraints { (con) in
            con.bottom.equalToSuperview().offset(-10)
            con.width.equalToSuperview()
            con.height.equalTo(0.5)
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
