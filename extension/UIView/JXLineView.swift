//
//  JXLineView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/3.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

extension UIView {
    
    class func createLine() -> UIView {
        let line = UIView()
        line.backgroundColor = UIColor.color(withHexString: JXLineColor)
        return line
    }
    
    class func createHorizontalLine(supperView: UIView, left: CGFloat, right: CGFloat, isTop: (Bool, CGFloat)) {
        let line = UIView.createLine()
        supperView.addSubview(line)
        line.layout {
            $0.leftAnchor.constraint(equalTo: supperView.leftAnchor, constant: left).activeTrue()
            $0.rightAnchor.constraint(equalTo: supperView.rightAnchor, constant: right).activeTrue()
            if isTop.0 {
                $0.topAnchor.constraint(equalTo: supperView.topAnchor, constant: isTop.1).activeTrue()
            }
            else {
                $0.bottomAnchor.constraint(equalTo: supperView.bottomAnchor, constant: isTop.1).activeTrue()
            }
            $0.heightAnchor.constraint(equalToConstant: onePixel).activeTrue()
        }
    }
    
    class func createVerticalLine(supperView: UIView, top: CGFloat, bottom: CGFloat, isLeft: (Bool, CGFloat)) {
        let line = UIView.createLine()
        supperView.addSubview(line)
        line.layout {
            $0.topAnchor.constraint(equalTo: supperView.topAnchor, constant: top).activeTrue()
            $0.bottomAnchor.constraint(equalTo: supperView.bottomAnchor, constant: bottom).activeTrue()
            if isLeft.0 {
                $0.leftAnchor.constraint(equalTo: supperView.leftAnchor, constant: isLeft.1).activeTrue()
            }
            else {
                $0.rightAnchor.constraint(equalTo: supperView.rightAnchor, constant: isLeft.1).activeTrue()
            }
            $0.widthAnchor.constraint(equalToConstant: onePixel).activeTrue()
        }
    }
}
