//
//  CustomButton.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/04/27.
//

import UIKit

@IBDesignable 
class CustomButton: UIButton {
    
    //MARK: - Property
    @IBInspectable let circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 78, height: 78)).cgPath
        layer.lineWidth = 2.3
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize(){
        layer.cornerRadius = frame.height / 2
        layer.addSublayer(self.circleLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /// 하드코딩
        circleLayer.frame.origin.x = (frame.width - 78) / 2
        circleLayer.frame.origin.y = (frame.height - 78) / 2
    }
}
