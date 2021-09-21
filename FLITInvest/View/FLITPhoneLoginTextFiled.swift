//
//  PhoneLoginTextFiled.swift
//  FLITInvest
//
//  Created by 董静 on 8/18/21.
//

import UIKit

class FLITPhoneLoginTextFiled: UITextField {

    private var isConfigured = false
    private var digitLabels = [UILabel]()
    
    private lazy var tapGesture : UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(becomeFirstResponder))
        return tapGesture
    }()
    
    func configure(with slotNumber:Int = 6) {
        guard isConfigured == false else {
            return
        }
        isConfigured.toggle()
        configureTextFiled()
        let stackView = createLabelsStackView(with: slotNumber)
        addSubview(stackView)
        addGestureRecognizer(tapGesture)
        
        stackView.snp.makeConstraints { (constrain) in
            constrain.top.equalToSuperview()
            constrain.left.equalToSuperview()
            constrain.right.equalToSuperview()
            constrain.bottom.equalToSuperview()
        }
    }
    
    private func configureTextFiled() {
        textColor = .clear
        tintColor = .clear
        textContentType = .oneTimeCode
        keyboardType = .numberPad
        addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
    }
    
    private func createLabelsStackView(with count: Int) -> UIStackView
    {
        let stackViwe = UIStackView()
        stackViwe.translatesAutoresizingMaskIntoConstraints = false
        stackViwe.axis = .horizontal
        stackViwe.alignment = .fill
        stackViwe.distribution = .fillEqually
        stackViwe.spacing = 2
        for _ in 0..<count{
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.textColor = .white
            label.font = .systemFont(ofSize: 40)
            label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            label.isUserInteractionEnabled = true
            stackViwe.addArrangedSubview(label)
            digitLabels.append(label)
        }
        return stackViwe
    }
    
    // MARK: Private Functions
    @objc func textDidChanged() {
        
        guard let text = self.text, text.count <= digitLabels.count else {
            return
        }
        
        for (i,currentLabel) in digitLabels.enumerated() {
            if i < text.count{
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            }else{
                currentLabel.text?.removeAll()
            }
        }
    }
}
