//
//  UIView+.swift
//  Clock-Clone
//
//  Created by subinyoon on 2022/07/07.
//

import UIKit

extension UIView {
    public func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
