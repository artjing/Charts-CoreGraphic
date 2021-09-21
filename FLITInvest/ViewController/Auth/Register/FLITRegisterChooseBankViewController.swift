//
//  FLITRegisterChooseBankViewController.swift
//  FLITInvest
//
//  Created by 董静 on 8/26/21.
//

import UIKit

class FLITRegisterChooseBankViewController: FLITRegistrationBaseViewController {

    
    // MARK: Views
    var bankData = [bankModel]()
    
    private let desLabel : UILabel = {
        let label = UILabel()
        label.text = "We want to link your account to xxx. We won’t use your money xxxx"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = FLITColor.text_label_gray
        label.textAlignment = .left
        return label
    }()
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    private let banksView : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentStep = 4
        setNewNavigationTitle(with: "Link your account")
        view.backgroundColor = .white
        
        // Add Subviews
        view.addSubview(desLabel)
        view.addSubview(searchBar)
        view.addSubview(banksView)
        
        banksView.register(FLITRegisterBankListTableViewCell.self, forCellReuseIdentifier: FLITRegisterBankListTableViewCell.identifier)
        
        banksView.delegate = self
        banksView.dataSource = self
        
        // dymmy data
        bankData.append(bankModel(bankImages: "Chase.png", bankName: "Chase Bank"))
        bankData.append(bankModel(bankImages: "BOA.png", bankName: "Bank of America"))
        bankData.append(bankModel(bankImages: "Ally.png", bankName: "Ally Bank"))
        bankData.append(bankModel(bankImages: "Chase.png", bankName: "Chase Bank"))
        bankData.append(bankModel(bankImages: "BOA.png", bankName: "Bank of America"))
        bankData.append(bankModel(bankImages: "Ally.png", bankName: "Ally Bank"))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        desLabel.snp.makeConstraints { (con) in
            con.top.equalToSuperview().offset(200)
            con.left.equalToSuperview().offset(30)
            con.right.equalToSuperview().offset(-30)
            con.height.equalTo(40)
        }
        
        searchBar.snp.makeConstraints { (con) in
            con.top.equalTo(desLabel.snp.bottom).offset(20)
            con.left.equalToSuperview().offset(50)
            con.right.equalToSuperview().offset(-50)
            con.height.equalTo(40)
        }
        
        banksView.snp.makeConstraints { (con) in
            con.width.equalToSuperview()
            con.top.equalTo(searchBar.snp.bottom).offset(20)
            con.bottom.equalToSuperview()
        }
    }
}

extension FLITRegisterChooseBankViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FLITRegisterBankListTableViewCell.identifier, for: indexPath) as! FLITRegisterBankListTableViewCell
        cell.selectionStyle = .none
        cell.config(model: bankData[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FLITRegisterBankInfoViewController()
        vc.config(bank: bankData[indexPath.row])
        navigationController?.pushViewController(FLITRegisterBankInfoViewController(), animated: true)
    }
}
