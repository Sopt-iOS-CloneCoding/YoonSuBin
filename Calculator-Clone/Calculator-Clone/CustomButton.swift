//
//  CustomButton.swift
//  Calculator-Clone
//
//  Created by subinyoon on 2022/06/24.
//

import UIKit

enum CustomButtonType: CaseIterable {
    case lightGreyBtn, DarkGreyBtn, OrangeBtn
}

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize(){
//        let buttonType = CustomButtonType.allCases
//        switch buttonType {
//            
//        }
        self.backgroundColor = .darkGray
        self.setTitleColor(UIColor.white, for: .normal)
//        self.layer.cornerRadius = frame.height / 2        
    }
}
