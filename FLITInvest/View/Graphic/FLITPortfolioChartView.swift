//
//  FLITPortfolioChartView.swift
//  FLITInvest
//
//  Created by 董静 on 9/7/21.
//

import UIKit

class FLITPortfolioChartView: UIView {
    
    var dataPoints = [0, 2, 6, 4, 5, 8, 10]
    var lineNum = 5
    
    private enum Constants {
        
        static let margin: CGFloat = 10.0
        static let colorAlpha : CGFloat = 0.3
        static let topBorder : CGFloat = 20
        static let bottomBorder : CGFloat = 0
        
    }
    
    private let gridLayer : CALayer = CAShapeLayer()
    
    private let lineLayer : CALayer = CAShapeLayer()
    
    private let lightCurveLayer : CAShapeLayer = CAShapeLayer()
    
    private let darCurveLayer : CAShapeLayer = CAShapeLayer()
    
    private let labelContainer : UIView = UIView()
    
    override func draw(_ rect: CGRect) {
        

        let width = rect.width
        let height = rect.height
        
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (colum: Int) -> Float in
            let spacing = graphWidth / CGFloat(self.dataPoints.count - 1)
            return Float(CGFloat(colum) * spacing + margin + 2)
        }
        
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        guard let maxValue = dataPoints.max() else {
            return
        }
        
        let columYPoint = { (graphPoint: Int) -> Float in
            let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return Float(graphHeight + topBorder - yPoint)
        }
        
        // the light curve
        let graghPath = CGMutablePath()
        
        let px = CGFloat(columnXPoint(dataPoints.count - 1))
        let py = CGFloat(columYPoint(dataPoints.last!))
        
        // 1, top curve
        graghPath.move(to: CGPoint(x: CGFloat(columnXPoint(0)), y: CGFloat(columYPoint(dataPoints[0]))))
        graghPath.addQuadCurve(to: CGPoint(x: px, y: py), control: CGPoint(x: px/2, y: CGFloat(columYPoint(dataPoints[0]))),transform: .identity)
        
        // 2, add right line
        //guard let clippingPath = graghPath.copy() as? UIBezierPath else { return }
        graghPath.addLine(to: CGPoint(
                                x: CGFloat(columnXPoint(dataPoints.count - 1)), y: py + 100))

        // 3, add bottom curve
        graghPath.addQuadCurve(to:CGPoint(x: CGFloat(columnXPoint(0)), y: CGFloat(columYPoint(dataPoints[0]))), control: CGPoint(x: px/2, y: CGFloat(columYPoint(dataPoints[0]))))
        
        // 4, clip and fill color
        //graghPath.addClip()
        //FLITColor.flit_light_blue.setFill()
        //let rectPath = UIBezierPath(rect: rect)
        //rectPath.fill()
        
        lightCurveLayer.path = graghPath
        lightCurveLayer.fillColor = FLITColor.flit_light_blue.cgColor
        layer.addSublayer(lightCurveLayer)
        
        
        // dark curve
        // the light curve
        let darkgraghPath = CGMutablePath()
        
        let px2 = CGFloat(columnXPoint(dataPoints.count - 1))
        let py2 = CGFloat(columYPoint(dataPoints.last!) + 30)
        
        // 1, top curve
        darkgraghPath.move(to: CGPoint(x: CGFloat(columnXPoint(0)), y: CGFloat(columYPoint(dataPoints[0]))))
        darkgraghPath.addQuadCurve(to: CGPoint(x: px2, y: py2), control: CGPoint(x: px2/2, y: CGFloat(columYPoint(dataPoints[0]))),transform: .identity)
        
        // 2, add right line
        //guard let clippingPath = graghPath.copy() as? UIBezierPath else { return }
        darkgraghPath.addLine(to: CGPoint(
                                x: CGFloat(columnXPoint(dataPoints.count - 1)), y: py + 70))

        // 3, add bottom curve
        darkgraghPath.addQuadCurve(to:CGPoint(x: CGFloat(columnXPoint(0)), y: CGFloat(columYPoint(dataPoints[0]))), control: CGPoint(x: px2/2, y: CGFloat(columYPoint(dataPoints[0]))))
        
        darCurveLayer.path = darkgraghPath
        darCurveLayer.fillColor = FLITColor.flit_light_mid_blue.cgColor
        layer.addSublayer(darCurveLayer)
        
        // drawing lines
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight/5 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight/5 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: 2 * graphHeight/5 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: 2 * graphHeight/5 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: 3 * graphHeight/5 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: 3 * graphHeight/5 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: 4 * graphHeight/5 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: 4 * graphHeight/5 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight + topBorder))
        
        let color =  FLITColor.login_textfiled_line
        color.setStroke()
        linePath.lineWidth = 1.0
        linePath.stroke()
        
    }
    
    func setUI() {
        
        // line labels
        for i in 0..<lineNum {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = FLITColor.login_textfiled_line
            label.text = "$\(20*(lineNum-i))k"
            labelContainer.addSubview(label)
            label.snp.makeConstraints { (con) in
                con.left.equalToSuperview().offset(10)
                print(i * (Int(height)/lineNum))
                con.top.equalToSuperview().offset(i * (Int(height - 20)/lineNum))
                con.width.equalTo(100)
            }
        }
        
        // col labels
        for i in 0..<lineNum {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = FLITColor.flit_light_mid_blue
            label.text = "\(2021+(i * 5))"
            labelContainer.addSubview(label)
            label.snp.makeConstraints { (con) in
                con.left.equalToSuperview().offset(i * Int(width)/lineNum + 20)
                print(i * (Int(height)/lineNum))
                con.bottom.equalTo(height + 20)
                con.width.equalTo(100)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()

    }
    func config() {
        addSubview(labelContainer)
    }
}
