//
//  JXButtonConvenient.swift
//  passwordManagement
//
//  Created by shanp on 16/8/8.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func convenient(withTitle title: String?, normalColor: UIColor?, highlightedColor: UIColor?, font: Float?, action: Selector?, target: AnyObject?, tag: Int?) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: UIControlState())
        if let titleFont = font {
            button.titleLabel?.font = UIFont(name: "ArialMT", size: CGFloat(titleFont))
        }
        
        button.setTitleColor(normalColor, for: UIControlState())
        button.setTitleColor(highlightedColor, for: .highlighted)
        button.convenient(action: action, target: target, tag: tag)
        return button
    }
    
    class func convenient(withNormalImage normalImage: UIImage?, highlightedImage: UIImage?, action: Selector?, target: AnyObject?, tag: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button .setImage(normalImage, for: UIControlState())
        button.setImage(highlightedImage, for: .highlighted)
        button.convenient(action: action, target: target, tag: tag)
        return button
    }
    
    class func convenient(withTitle title: String?, normalColor: UIColor?, highlightedColor: UIColor?, font: Float?, normalImage: UIImage?, highlightedImage: UIImage?, action: Selector?, target: AnyObject?, tag: Int?) -> UIButton {
        let button = UIButton.convenient(withTitle: title, normalColor: normalColor, highlightedColor: highlightedColor, font: font, action: action, target: target, tag: tag)
        button .setImage(normalImage, for: UIControlState())
        button.setImage(highlightedImage, for: .highlighted)
        return button
    }
    
    private func convenient(action selector: Selector?, target: AnyObject?, tag: Int?) -> Void {
        if let action = selector {
            self.addTarget(target, action: action, for: .touchUpInside)
        }
        if let buttonTag = tag {
            self.tag = buttonTag
        }
    }
}
