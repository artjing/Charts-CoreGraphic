//
//  PortfolioCircleView.swift
//  FLITInvest
//
//  Created by 董静 on 8/31/21.
//

import UIKit

class PortfolioCircleView: UIView {

    var counter = 1
    
    // if left or right circle been folded
    var lfolded : Bool = false
    var rfolded : Bool = false
    
    // dark blue circle animation
    var darkBlueAnimationPath = UIBezierPath()
    var darkCirclePath = UIBezierPath()
    var darkShapeLayer  = CAShapeLayer()
    
    // light blue circle animation
    var lightBlueAnimationPath = UIBezierPath()
    var lightCirclePath = UIBezierPath()
    var lightShapeLayer  = CAShapeLayer()
    
    private struct Constants {
        static let numberOfStocks = 8
        static let lineWidth : CGFloat = 20
        static let arcWidth : CGFloat = 20
        static var halfOfLineWidth : CGFloat {
            return lineWidth/2
        }
    }
    
    private let testButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        return button
    }()
    
    private let stockLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Stock"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = FLITColor.flit_light_logo_mid_blue
        return label
    }()
    
    private let stockNumberLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "35%"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = FLITColor.flit_gray_label
        return label
    }()
    
    private let bondsLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Bounds"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = FLITColor.flit_light_blue
        return label
    }()
    
    private let bondsNumberLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "65%"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = FLITColor.flit_gray_label
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = bounds.height
        let startAngle : CGFloat = 5 * .pi / 4
        let endAngle : CGFloat = 3 * .pi / 4
        let lineColor = FLITColor.flit_light_blue
        let outlineColor = FLITColor.flit_light_logo_mid_blue
        
        lightCirclePath = UIBezierPath (
            arcCenter: center,
            radius: radius/2 - Constants.arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        // Drewed on the CAShapeLayer
        //lightCirclePath.close()
        //lightCirclePath.lineWidth = Constants.lineWidth
        //lineColor.setStroke()
        //lightCirclePath.stroke()
        
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOfStocks)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        // new angles -- using
        let darkstartAngle : CGFloat = 5 * .pi / 4
        let darkendAngle : CGFloat = 3 * .pi / 4
        
        let outerRrcRadius = bounds.height/2 - Constants.halfOfLineWidth
        darkCirclePath = UIBezierPath(
            arcCenter: center,
            radius: outerRrcRadius,
            startAngle: darkendAngle,
            endAngle: darkstartAngle,
            clockwise: true
        )
        
        let innerArcRadius = bounds.height/2 - Constants.arcWidth + Constants.halfOfLineWidth
        darkCirclePath.addArc(
            withCenter: center,
            radius: innerArcRadius,
            startAngle: darkstartAngle,
            endAngle: darkendAngle,
            clockwise: false)
        
        darkCirclePath.close()
        outlineColor.setStroke()
        darkCirclePath.lineWidth = Constants.lineWidth
        //darkCirclePath.stroke()
        
        // for the animatoion
        darkBlueAnimationPath = UIBezierPath(
            arcCenter: center,
            radius: outerRrcRadius,
            startAngle: darkendAngle,
            endAngle: darkstartAngle,
            clockwise: true
        )
        
        darkBlueAnimationPath.addArc(
            withCenter: center,
            radius: innerArcRadius,
            startAngle: darkstartAngle,
            endAngle: darkendAngle,
            clockwise: false)
        
        outlineColor.setStroke()
        darkBlueAnimationPath.lineWidth = Constants.lineWidth
        
        
        lightShapeLayer.strokeColor = lineColor.cgColor
        lightShapeLayer.fillColor = UIColor.clear.cgColor
        lightShapeLayer.lineWidth = Constants.lineWidth
        lightShapeLayer.path = lightCirclePath.cgPath
        layer.addSublayer(lightShapeLayer)
        
        darkShapeLayer.strokeColor = outlineColor.cgColor
        darkShapeLayer.fillColor = UIColor.clear.cgColor
        darkShapeLayer.lineWidth = Constants.lineWidth
        darkShapeLayer.path = darkCirclePath.cgPath
        layer.addSublayer(darkShapeLayer)

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stockLabel.snp.makeConstraints { (con) in
            con.left.equalToSuperview()
            con.centerY.equalToSuperview()
            con.width.equalTo(100)
            con.height.equalTo(20)
        }
        
        stockNumberLabel.snp.makeConstraints { (con) in
            con.left.equalTo(stockLabel.snp.left).offset(10)
            con.top.equalTo(stockLabel.snp.bottom).offset(5)
            con.width.equalTo(100)
            con.height.equalTo(20)
        }
        
        bondsLabel.snp.makeConstraints { (con) in
            con.right.equalToSuperview()
            con.centerY.equalToSuperview()
            con.width.equalTo(100)
            con.height.equalTo(20)
        }
        
        bondsNumberLabel.snp.makeConstraints { (con) in
            con.right.equalTo(bondsLabel.snp.right).offset(-10)
            con.top.equalTo(bondsLabel.snp.bottom).offset(5)
            con.width.equalTo(100)
            con.height.equalTo(20)
        }

    }
    
    func addLeftAnimation(_ on: Bool) {
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        let path = darkCirclePath.cgPath
        pathAnimation.toValue = path
        pathAnimation.duration = 15.0
        pathAnimation.autoreverses = true
        pathAnimation.repeatCount = .greatestFiniteMagnitude
        
        // size
        let w = on ?  Constants.lineWidth + 7 : Constants.lineWidth
        darkShapeLayer.lineWidth = w
        
        // shadow
        if on {
            darkShapeLayer.shadowRadius = 3
            darkShapeLayer.shadowOpacity = 0.4
            darkShapeLayer.shadowColor = UIColor.black.cgColor
            darkShapeLayer.fillColor = UIColor.gray.cgColor
            darkShapeLayer.shadowOffset = CGSize(width: 1, height: 0)
        }else{
            darkShapeLayer.shadowRadius = 0
            darkShapeLayer.shadowOpacity = 0
        }
        
        darkShapeLayer.add(pathAnimation, forKey: "pathAnimation")
    }
    
    func addRightAnimation(_ on: Bool) {
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        let path = lightCirclePath.cgPath
        pathAnimation.toValue = path
        pathAnimation.duration = 15.0
        pathAnimation.autoreverses = true
        pathAnimation.repeatCount = .greatestFiniteMagnitude
        
        // size
        let w = on ?  Constants.lineWidth + 7 : Constants.lineWidth
        lightShapeLayer.lineWidth = w
        
        // shadow
        if on {
            lightShapeLayer.shadowRadius = 3
            lightShapeLayer.shadowOpacity = 0.4
            lightShapeLayer.shadowColor = UIColor.black.cgColor
            lightShapeLayer.fillColor = UIColor.clear.cgColor
            lightShapeLayer.shadowOffset = CGSize(width: 1, height: 0)
        }else{
            lightShapeLayer.shadowRadius = 0
            lightShapeLayer.shadowOpacity = 0
        }
        
        lightShapeLayer.add(pathAnimation, forKey: "pathAnimation")
    }
    
    func config(){
        addSubview(stockLabel)
        addSubview(stockNumberLabel)
        addSubview(bondsLabel)
        addSubview(bondsNumberLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        guard let point = touch?.location(in: self) else { return }
        
        if darkCirclePath.contains(point) {
            
            // unfolder the other one
            if rfolded == true {
                rfolded.toggle()
                addRightAnimation(false)
            }
            
            // add animation
            if lfolded == false {
                addLeftAnimation(true)
            }else {
                addLeftAnimation(false)
            }
            lfolded.toggle()
        }
        
        if lightCirclePath.contains(point) {
            
            // unfolder the other one
            if lfolded == true {
                lfolded.toggle()
                addLeftAnimation(false)
            }
            
            // add animation
            if rfolded == false {
                addRightAnimation(true)
            }else {
                addRightAnimation(false)
            }
            rfolded.toggle()
        }
    }
}
