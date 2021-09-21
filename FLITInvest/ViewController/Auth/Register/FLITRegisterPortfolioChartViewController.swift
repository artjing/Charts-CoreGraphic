//
//  FLITRegisterPortfolioChartViewController.swift
//  FLITInvest
//
//  Created by 董静 on 9/7/21.
//

import UIKit


class FLITRegisterPortfolioChartViewController: FLITRegistrationBaseViewController {
    
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
        label.textAlignment = .left
        label.text = "Initial investment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private let titleTwoLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Reoccuring contribution"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private let titleTextInput : UITextField = {
        let textView = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        label.text = "  $ "
        label.textAlignment = .center
        label.textColor = FLITColor.flit_light_logo_mid_blue
        label.font = UIFont.systemFont(ofSize: 16)
        textView.leftView = label
        textView.leftViewMode = .always
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = FLITColor.flit_light_logo_mid_blue
        textView.backgroundColor = FLITColor.flit_light_blue.withAlphaComponent(0.5)
        return textView
    }()
    
    private let titleTextTwoInput : UITextField = {
        let textView = UITextField()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        label.text = "  $ "
        label.textAlignment = .center
        label.textColor = FLITColor.flit_light_logo_mid_blue
        label.font = UIFont.systemFont(ofSize: 16)
        textView.leftViewMode = .always
        textView.leftView = label
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = FLITColor.flit_light_logo_mid_blue
        textView.backgroundColor = FLITColor.flit_light_blue.withAlphaComponent(0.5)
        return textView
    }()
    
    private let titleTwoTextInput : FLITPhoneLoginTextFiled = {
        let textView = FLITPhoneLoginTextFiled()
        textView.backgroundColor = FLITColor.flit_light_blue.withAlphaComponent(0.5)
        return textView
    }()
    
    //    private let portfolioCircleChart :PortfolioCircleView = {
    //        let view = PortfolioCircleView()
    //        return view
    //    }()
    
    private let portfolioCircleChart :FLITPortfolioChartView = {
        let view = FLITPortfolioChartView()
        return view
    }()
    
    private let stockLineLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "Your worst month would be down x% from xxx to xxx"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = FLITColor.text_label_gray
        return label
        
    }()
    
    private let stockLine : UIView = {
        let view = UIView()
        view.backgroundColor = FLITColor.flit_light_blue
        view.alpha = 0.3
        return view
    }()
    
    private let bondsLineLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "View disclosures"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = FLITColor.flit_light_logo_mid_blue
        return label
        
    }()
    
    private let TopButton:UIButton = {
        let button = UIButton()
        button.setTitle("Why this portfolio ?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(FLITColor.flit_light_logo_mid_blue, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didSelectedWhyButton), for: .touchUpInside)
        return button
    }()

    private let portfolioButton:UIButton = {
        let button = UIButton()
        button.setTitle("Use this portfolio", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = FLITColor.flit_light_logo_mid_blue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didSelectedEditButton), for: .touchUpInside)
        return button
    }()
    
    
    private let editButton:UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = FLITColor.flit_light_logo_mid_blue.cgColor
        button.setTitleColor(FLITColor.flit_light_logo_mid_blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didSelectedEditButton), for: .touchUpInside)
        return button
    }()
    
    private let stockTwoTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        currentStep = 0
        setNewNavigationTitle(with: "You made it Sarah!")
        addSubtitle(with: "This is your recommended portfolio for you...")
        // portfolio view
        portfolioCircleChart.backgroundColor = .white
        portfolioCircleChart.config()
        
        // add views
        view.addSubview(portfolioCircleChart)
        view.addSubview(titleLabel)
        view.addSubview(titleTwoLabel)
        view.addSubview(stockLineLabel)
        view.addSubview(bondsLineLabel)
        view.addSubview(titleTextInput)
        view.addSubview(titleTextTwoInput)
        view.addSubview(TopButton)
        view.addSubview(portfolioButton)
        view.addSubview(editButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        titleLabel.snp.makeConstraints { (con) in
            con.top.equalToSuperview().offset(180)
            con.left.equalToSuperview().offset(30)
            con.width.equalTo(view.width*0.5)
            con.height.equalTo(20)
        }
        
        titleTextInput.snp.makeConstraints { (con) in
            con.top.equalTo(titleLabel.snp.bottom).offset(10)
            con.left.equalToSuperview().offset(30)
            con.width.equalTo(150)
            con.height.equalTo(30)
        }
        
        titleTwoLabel.snp.makeConstraints { (con) in
            con.top.equalToSuperview().offset(180)
            con.width.equalTo(view.width*0.5)
            con.left.equalTo(view.snp.centerX)
            con.height.equalTo(20)
        }
        
        titleTextTwoInput.snp.makeConstraints { (con) in
            con.top.equalTo(titleTwoLabel.snp.bottom).offset(10)
            con.left.equalTo(view.snp.centerX)
            con.width.equalTo(150)
            con.height.equalTo(30)
        }
        
        portfolioCircleChart.snp.makeConstraints({ (con) in
            con.top.equalTo(titleTextTwoInput.snp.bottom).offset(50)
            con.width.equalTo(view.width - 70)
            con.height.equalTo(view.width - 160)
            con.left.equalToSuperview().offset(35)
        })
        
        stockLineLabel.snp.makeConstraints { (con) in
            con.top.equalTo(portfolioCircleChart.snp.bottom).offset(50)
            con.left.equalToSuperview().offset(30)
            con.width.equalToSuperview().offset(-60)
            con.height.equalTo(45)
        }
        
        TopButton.snp.makeConstraints { (con) in
            con.top.equalTo(stockLineLabel.snp.bottom).offset(10)
            con.left.equalToSuperview().offset(25)
            con.width.equalTo(150)
            con.height.equalTo(20)
        }
        
        bondsLineLabel.snp.makeConstraints { (con) in
            con.top.equalTo(TopButton.snp.bottom).offset(10)
            con.left.equalToSuperview().offset(30)
            con.width.equalTo(150)
            con.height.equalTo(20)
        }
        
        portfolioButton.snp.makeConstraints { (con) in
            con.top.equalTo(bondsLineLabel.snp.bottom).offset(18)
            con.left.equalToSuperview().offset(75)
            con.width.equalToSuperview().offset(-150)
            con.height.equalTo(42)
        }
        
        editButton.snp.makeConstraints { (con) in
            con.top.equalTo(portfolioButton.snp.bottom).offset(10)
            con.left.equalToSuperview().offset(75)
            con.width.equalToSuperview().offset(-150)
            con.height.equalTo(42)
        }
    }
    
    
    // button private functions
    @objc func didSelectedEditButtond() {
        
    }
    
    @objc func didSelectedEditButton() {
        navigationController?.pushViewController(FLITRegisterConfirmPortfolioViewController(), animated: true)
    }
    
    @objc func didSelectedWhyButton() {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        present(vc, animated: true) {
            
        }
    }
    
}
