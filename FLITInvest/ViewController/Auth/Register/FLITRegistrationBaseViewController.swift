//
//  FLITRegistrationBaseViewController.swift
//  FLITInvest
//
//  Created by 董静 on 8/21/21.
//

import UIKit

class FLITRegistrationBaseViewController: UIViewController {

    
    var currentStep = 1
    var ishideNav = false
    
    public func setNewNavigationTitle(with string: String){
        newNavitationBarTitleView.text = string
    }
    
    private let newNavigationBar : UIImageView = {
        let nvBar = UIImageView()
        nvBar.image = UIImage(named: "newNVBar")
        return nvBar
    }()
    
    private let newNavitationBarTitleView : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let newNavitationBarBubTitleView : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let navigationStepIndicator : UIView = {
        let view = UIView()
        view.backgroundColor = FLITColor.flit_light_blue
        view.layer.cornerRadius = 3
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newNavigationBar)
        view.addSubview(newNavitationBarTitleView)
        view.addSubview(navigationStepIndicator)
    }
    
    func addCustomBackButton() {
        let backImage = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action:  #selector(didClickBack))
        leftButton.tintColor = .white
        if ishideNav {
            leftButton.tintColor = .black
        }
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.backBarButtonItem = leftButton
    }
    
    func addNoNavBackButton() {
        let backImage = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action:  #selector(didClickBack))
        leftButton.tintColor = .black
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.backBarButtonItem = leftButton
    }
    
    
    @objc func didClickBack() {
        navigationController?.popViewController(animated: true)
    }
    struct System {
        static func clearNavigationBar(with navBar: UINavigationBar) {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let naviController = navigationController {
            System.clearNavigationBar(with: naviController.navigationBar)
            naviController.view.backgroundColor = .clear
        }
        addCustomBackButton()

        // Customized system navigation bar
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        newNavigationBar.snp.makeConstraints { (con) in
            con.center.equalToSuperview()
            con.top.equalToSuperview()
            con.width.equalToSuperview()
            con.height.equalTo(self.view.snp.width).multipliedBy(145.0/375.0)
        }
        
        newNavitationBarTitleView.snp.makeConstraints { (con) in
            con.width.equalToSuperview()
            con.height.equalTo(30)
            con.bottom.equalTo(newNavigationBar.snp.bottom).offset(-20)
        }
        
        navigationStepIndicator.snp.makeConstraints { (con) in
            con.width.equalTo(15 * currentStep)
            con.height.equalTo(5)
            con.bottom.equalTo(newNavigationBar.snp.bottom)
            con.left.equalTo(newNavigationBar.left).offset(37)
        }
    }
    
    func addSubtitle(with string: String){
        
        
        view.addSubview(newNavitationBarBubTitleView)
        
        newNavitationBarBubTitleView.text = string
        
        newNavitationBarTitleView.snp.makeConstraints { (con) in
            con.width.equalToSuperview()
            con.height.equalTo(30)
            con.bottom.equalTo(newNavigationBar.snp.bottom).offset(-35)
        }
        
        newNavitationBarBubTitleView.snp.makeConstraints { (con) in
            con.width.equalToSuperview()
            con.height.equalTo(30)
            con.bottom.equalTo(newNavigationBar.snp.bottom).offset(-10)
        }
    }
    
    func hideNav(){
        newNavigationBar.image = nil
        ishideNav = true
        view.setNeedsLayout()
    }
}
