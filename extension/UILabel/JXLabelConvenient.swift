//
//  JXLabelConvenient.swift
//  passwordManagement
//
//  Created by shanp on 16/8/10.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

extension UILabel {
    
    class func convenient(title: String?, titleColor: UIColor?, font: Float?, tag: Int?, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = titleColor
        if let titleFont = font {
            label.font = UIFont(name: "ArialMT", size: CGFloat(titleFont))
        }
        if let labelTag = tag {
            label.tag = labelTag
        }
        label.textAlignment = textAlignment
        return label
    }
    
}
