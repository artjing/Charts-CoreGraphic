//
//  FLITRegisterConfirmPortfolioViewController.swift
//  FLITInvest
//
//  Created by 董静 on 8/26/21.
//

import UIKit

class FLITRegisterConfirmPortfolioViewController: FLITRegistrationBaseViewController {
    
    var dataSource : [FLITPortfolioModel] = {
        return [
                FLITPortfolioModel(name: "U.S stocks one", number: "$213.45", rate: "45.23%", tag: "ESGU"),
                FLITPortfolioModel(name: "U.S stocks one", number: "$213.45", rate: "45.23%", tag: "ESGU")]
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
        label.text = "Stocks"
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
        label.text = "Bonds"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label    }()
    
    private let bondsLine : UIView = {
        let view = UIView()
        view.backgroundColor = FLITColor.flit_light_blue
        view.alpha = 0.3
        return view
    }()
    
    private let stockTableView : UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let stockTwoTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        currentStep = 0
        setNewNavigationTitle(with: "Portfolio Details")
        
        // portfolio view
        portfolioCircleChart.backgroundColor = .white
        portfolioCircleChart.config()
        
        // add views
        view.addSubview(portfolioCircleChart)
        view.addSubview(titleLabel)
        view.addSubview(titleTwoLabel)
        view.addSubview(stockLine)
        view.addSubview(stockLineLabel)
        view.addSubview(bondsLine)
        view.addSubview(bondsLineLabel)
        view.addSubview(stockTableView)
        view.addSubview(stockTwoTableView)
        
        stockTableView.delegate = self
        stockTableView.dataSource = self
        stockTwoTableView.delegate = self
        stockTwoTableView.dataSource = self
        stockTableView.register(FLITPortfolioTableViewCell.self, forCellReuseIdentifier: FLITPortfolioTableViewCell.identifier)
        stockTwoTableView.register(FLITPortfolioTableViewCell.self, forCellReuseIdentifier: FLITPortfolioTableViewCell.identifier)

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
        
        stockLine.snp.makeConstraints { (con) in
            con.top.equalTo(portfolioCircleChart.snp.bottom).offset(30)
            con.left.equalToSuperview().offset(30)
            con.right.equalToSuperview().offset(-30)
            con.height.equalTo(37)
        }
        
        stockLineLabel.snp.makeConstraints { (con) in
            con.centerY.equalTo(stockLine.snp.centerY)
            con.left.equalTo(stockLine.snp.left).offset(30)
            con.width.equalTo(150)
            con.height.equalTo(37)
        }
        
        stockTableView.snp.makeConstraints { (con) in
            con.top.equalTo(stockLineLabel.snp.bottom).offset(10)
            con.left.equalTo(stockLine.snp.left).offset(10)
            con.width.equalToSuperview().offset(-80)
            con.height.equalTo(dataSource.count * 80)
        }
        
        bondsLine.snp.makeConstraints { (con) in
            con.top.equalTo(stockTableView.snp.bottom).offset(30)
            con.left.equalToSuperview().offset(30)
            con.right.equalToSuperview().offset(-30)
            con.height.equalTo(37)
        }
        
        bondsLineLabel.snp.makeConstraints { (con) in
            con.centerY.equalTo(bondsLine.snp.centerY)
            con.left.equalTo(bondsLine.snp.left).offset(30)
            con.width.equalTo(150)
            con.height.equalTo(37)
        }
        
        stockTwoTableView.snp.makeConstraints { (con) in
            con.top.equalTo(bondsLineLabel.snp.bottom).offset(10)
            con.left.equalTo(stockLine.snp.left).offset(10)
            con.width.equalTo(view.snp.width).offset(-80)
            con.height.equalTo(dataSource.count * 80)
        }
    }
}

extension FLITRegisterConfirmPortfolioViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == stockTableView {
            return dataSource.count
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == stockTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FLITPortfolioTableViewCell.identifier, for: indexPath) as! FLITPortfolioTableViewCell
            cell.config(FLITPortfolioModel(name: "U.S stocks one", number: "$213.45", rate: "45.23%", tag: "ESGU"))
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FLITPortfolioTableViewCell.identifier, for: indexPath) as! FLITPortfolioTableViewCell
        cell.config(FLITPortfolioModel(name: "U.S stocks one", number: "$213.45", rate: "45.23%", tag: "ESGU"))
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(FLITRegisterConfirmPortfolioTwoViewController(), animated: true)
    }
}
