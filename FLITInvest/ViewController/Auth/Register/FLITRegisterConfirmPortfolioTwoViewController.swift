
//
//  FLITRegisterConfirmPortfolioViewController.swift
//  FLITInvest
//
//  Created by 董静 on 8/26/21.
//

import UIKit

class FLITRegisterConfirmPortfolioTwoViewController: FLITRegistrationBaseViewController {
    
    var dataSource : [FLITPortfolioContryModel] = {
        return [
            FLITPortfolioContryModel(country: "U.S", number: 7, rate: "70%"),
            FLITPortfolioContryModel(country: "Europe", number: 2, rate: "20%"),
            FLITPortfolioContryModel(country: "Japan", number: 0.8, rate: "8%"),
            FLITPortfolioContryModel(country: "Other", number: 0.2, rate: "2%"),
            FLITPortfolioContryModel(country: "Other", number: 0.2, rate: "2%")]
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Allocations"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let titleTwoLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Click stocks / bonds to see allocations"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = FLITColor.flit_light_gray_label
        return label
    }()
    
    private let portfolioCircleChart :PortfolioCircleView = {
        let view = PortfolioCircleView()
        return view
    }()
    
    
    private let stockLineLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Geographic"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label    }()
    
    private let stockLine : UIView = {
        let view = UIView()
        view.backgroundColor = FLITColor.flit_light_blue
        view.alpha = 0.3
        return view
    }()
    
    private let bondsLineLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Sector"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label    }()
    
    private let stockTableView : UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let stockTwoTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let portfolioButton:UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = FLITColor.flit_light_logo_mid_blue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didSelectedEditButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        currentStep = 0
        setNewNavigationTitle(with: "Allocations")
        hideNav()
        
        // portfolio view
        portfolioCircleChart.backgroundColor = .white
        portfolioCircleChart.config()
        
        // add views
        view.addSubview(portfolioCircleChart)
        view.addSubview(titleLabel)
        view.addSubview(titleTwoLabel)
        view.addSubview(stockLineLabel)
        view.addSubview(bondsLineLabel)
        view.addSubview(stockTableView)
        view.addSubview(portfolioButton)
        //view.addSubview(stockTwoTableView)
        
        stockTableView.delegate = self
        stockTableView.dataSource = self
        stockTwoTableView.delegate = self
        stockTwoTableView.dataSource = self
        stockTableView.register(FLITPortfolioTwoTableViewCell.self, forCellReuseIdentifier: FLITPortfolioTwoTableViewCell.identifier)
        stockTwoTableView.register(FLITPortfolioTwoTableViewCell.self, forCellReuseIdentifier: FLITPortfolioTwoTableViewCell.identifier)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.snp.makeConstraints { (con) in
            con.top.equalToSuperview().offset(180)
            con.width.equalTo(view.width)
            con.height.equalTo(20)
        }
        
        titleTwoLabel.snp.makeConstraints { (con) in
            con.top.equalTo(titleLabel.snp.bottom).offset(10)
            con.width.equalTo(view.width)
            con.height.equalTo(20)
        }
        
        portfolioCircleChart.snp.makeConstraints({ (con) in
            con.top.equalTo(titleTwoLabel.snp.bottom).offset(20)
            con.width.equalTo(view.width - 70)
            con.height.equalTo(view.width - 240)
            con.left.equalToSuperview().offset(35)
        })
        
        stockLineLabel.snp.makeConstraints { (con) in
            con.top.equalTo(portfolioCircleChart.snp.bottom).offset(50)
            con.left.equalToSuperview().offset(30)
            con.width.equalTo(100)
            con.height.equalTo(37)
        }
        
        stockTableView.snp.makeConstraints { (con) in
            con.top.equalTo(stockLineLabel.snp.bottom).offset(10)
            con.left.equalTo(stockLineLabel.snp.left).offset(10)
            con.width.equalToSuperview().offset(-80)
            con.height.equalTo(dataSource.count * 40)
        }
        
        bondsLineLabel.snp.makeConstraints { (con) in
            con.top.equalTo(portfolioCircleChart.snp.bottom).offset(50)
            con.left.equalTo(stockLineLabel.snp.right).offset(10)
            con.width.equalTo(150)
            con.height.equalTo(37)
        }
        
        portfolioButton.snp.makeConstraints { (con) in
            con.bottom.equalToSuperview().offset(-60)
            con.left.equalToSuperview().offset(75)
            con.width.equalToSuperview().offset(-150)
            con.height.equalTo(42)
        }
        
    }
    
    @objc func didSelectedEditButton() {
        navigationController?.pushViewController(FLITRegistrationViewController(), animated: true)
    }
}

extension FLITRegisterConfirmPortfolioTwoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == stockTableView {
            return dataSource.count
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == stockTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FLITPortfolioTwoTableViewCell.identifier, for: indexPath) as! FLITPortfolioTwoTableViewCell
            cell.confic(dataSource[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FLITPortfolioTwoTableViewCell.identifier, for: indexPath) as! FLITPortfolioTwoTableViewCell
        cell.confic(dataSource[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
